import 'package:flutter/material.dart';

import '../domain/vocabulary_entry.dart';
import '../domain/vocabulary_repository.dart';

class VocabularyPage extends StatefulWidget {
  const VocabularyPage({required this.repository, super.key});

  final VocabularyRepository repository;

  @override
  State<VocabularyPage> createState() => _VocabularyPageState();
}

class _VocabularyPageState extends State<VocabularyPage> {
  VocabularyStatus? _filter;
  late final Stream<List<VocabularyEntry>> _entries;

  @override
  void initState() {
    super.initState();
    _entries = widget.repository.watchAll();
  }

  Future<void> _updateStatus(
    VocabularyEntry entry,
    VocabularyStatus status,
  ) async {
    try {
      await widget.repository.updateStatus(entry.id, status);
    } on Object {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível atualizar a palavra.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vocabulário')),
      body: StreamBuilder<List<VocabularyEntry>>(
        stream: _entries,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const _VocabularyState(
              icon: Icons.error_outline,
              title: 'Não foi possível carregar o vocabulário',
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final allEntries = snapshot.data!;
          final entries = _filter == null
              ? allEntries
              : allEntries.where((entry) => entry.status == _filter).toList();

          return Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: Row(
                  children: [
                    FilterChip(
                      label: const Text('Todas'),
                      selected: _filter == null,
                      onSelected: (_) => setState(() => _filter = null),
                    ),
                    const SizedBox(width: 8),
                    for (final status in VocabularyStatus.values) ...[
                      FilterChip(
                        avatar: Icon(
                          _statusIcon(status),
                          size: 18,
                          color: _statusColor(context, status),
                        ),
                        label: Text(status.label),
                        selected: _filter == status,
                        onSelected: (_) => setState(() => _filter = status),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ],
                ),
              ),
              Expanded(
                child: entries.isEmpty
                    ? _VocabularyState(
                        icon: allEntries.isEmpty
                            ? Icons.bookmark_border
                            : Icons.filter_alt_off_outlined,
                        title: allEntries.isEmpty
                            ? 'Nenhuma palavra salva'
                            : 'Nenhuma palavra neste filtro',
                      )
                    : LayoutBuilder(
                        builder: (context, constraints) {
                          final horizontalPadding = constraints.maxWidth > 700
                              ? (constraints.maxWidth - 680) / 2
                              : 16.0;
                          return ListView.separated(
                            padding: EdgeInsets.fromLTRB(
                              horizontalPadding,
                              4,
                              horizontalPadding,
                              32,
                            ),
                            itemCount: entries.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final entry = entries[index];
                              return _VocabularyCard(
                                entry: entry,
                                onStatusChanged: (status) =>
                                    _updateStatus(entry, status),
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _VocabularyCard extends StatelessWidget {
  const _VocabularyCard({required this.entry, required this.onStatusChanged});

  final VocabularyEntry entry;
  final ValueChanged<VocabularyStatus> onStatusChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    entry.word,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Icon(
                  _statusIcon(entry.status),
                  color: _statusColor(context, entry.status),
                  semanticLabel: entry.status.label,
                ),
              ],
            ),
            if (entry.meaning.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(entry.meaning),
            ],
            const SizedBox(height: 14),
            SegmentedButton<VocabularyStatus>(
              showSelectedIcon: false,
              segments: [
                for (final status in VocabularyStatus.values)
                  ButtonSegment(
                    value: status,
                    icon: Icon(_statusIcon(status)),
                    tooltip: status.label,
                  ),
              ],
              selected: {entry.status},
              onSelectionChanged: (selection) {
                onStatusChanged(selection.single);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _VocabularyState extends StatelessWidget {
  const _VocabularyState({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 64, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

Color _statusColor(BuildContext context, VocabularyStatus status) {
  return switch (status) {
    VocabularyStatus.unreviewed => Theme.of(
      context,
    ).colorScheme.onSurfaceVariant,
    VocabularyStatus.learning => Theme.of(context).colorScheme.error,
    VocabularyStatus.known => const Color(0xFF247A45),
  };
}

IconData _statusIcon(VocabularyStatus status) {
  return switch (status) {
    VocabularyStatus.unreviewed => Icons.circle_outlined,
    VocabularyStatus.learning => Icons.error_outline,
    VocabularyStatus.known => Icons.check_circle_outline,
  };
}
