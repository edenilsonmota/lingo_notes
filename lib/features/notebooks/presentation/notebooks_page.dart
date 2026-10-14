import 'package:flutter/material.dart';

import '../../texts/domain/dialogue_file_picker.dart';
import '../../texts/domain/text_repository.dart';
import '../../texts/presentation/notebook_texts_page.dart';
import '../domain/notebook.dart';
import '../domain/notebook_repository.dart';
import 'notebook_form_dialog.dart';

class NotebooksPage extends StatefulWidget {
  const NotebooksPage({
    required this.repository,
    required this.textRepository,
    required this.filePicker,
    super.key,
  });

  final NotebookRepository repository;
  final TextRepository textRepository;
  final DialogueFilePicker filePicker;

  @override
  State<NotebooksPage> createState() => _NotebooksPageState();
}

class _NotebooksPageState extends State<NotebooksPage> {
  late final Stream<List<Notebook>> _notebooks;

  @override
  void initState() {
    super.initState();
    _notebooks = widget.repository.watchAll();
  }

  Future<void> _openForm([Notebook? notebook]) async {
    final result = await showDialog<NotebookFormResult>(
      context: context,
      builder: (_) => NotebookFormDialog(notebook: notebook),
    );
    if (result == null) return;

    try {
      if (notebook == null) {
        await widget.repository.create(
          name: result.name,
          description: result.description,
          colorValue: result.colorValue,
        );
      } else {
        await widget.repository.update(
          notebook.copyWith(
            name: result.name,
            description: result.description,
            colorValue: result.colorValue,
          ),
        );
      }
    } on Object {
      if (mounted) _showError('Não foi possível salvar o caderno.');
    }
  }

  Future<void> _confirmDelete(Notebook notebook) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir caderno?'),
        content: Text('O caderno “${notebook.name}” será excluído.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton.tonal(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    try {
      await widget.repository.delete(notebook.id);
    } on Object {
      if (mounted) _showError('Não foi possível excluir o caderno.');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _changeSortMode(NotebookSortMode mode) async {
    try {
      await widget.repository.setSortMode(mode);
    } on Object {
      if (mounted) _showError('Não foi possível alterar a ordenação.');
    }
  }

  Future<void> _reorder(
    List<Notebook> notebooks,
    int oldIndex,
    int newIndex,
  ) async {
    final reordered = List<Notebook>.of(notebooks);
    final moved = reordered.removeAt(oldIndex);
    reordered.insert(newIndex, moved);
    await widget.repository.reorder(reordered);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Lingo Notes'),
            Text(
              'Seus cadernos',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        actions: [
          PopupMenuButton<NotebookSortMode>(
            tooltip: 'Ordenar cadernos',
            icon: const Icon(Icons.sort),
            onSelected: _changeSortMode,
            itemBuilder: (context) => [
              for (final mode in NotebookSortMode.values)
                PopupMenuItem(value: mode, child: Text(mode.label)),
            ],
          ),
        ],
      ),
      body: StreamBuilder<List<Notebook>>(
        stream: _notebooks,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const _MessageState(
              icon: Icons.cloud_off_outlined,
              title: 'Não foi possível carregar os cadernos',
              message: 'Feche e abra o aplicativo para tentar novamente.',
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final notebooks = snapshot.data!;
          if (notebooks.isEmpty) {
            return const _MessageState(
              icon: Icons.menu_book_outlined,
              title: 'Crie seu primeiro caderno',
              message: 'Organize textos e estudos de inglês por assunto.',
            );
          }

          final manual = notebooks.first.sortMode == NotebookSortMode.manual;
          return LayoutBuilder(
            builder: (context, constraints) {
              final horizontalPadding = constraints.maxWidth > 700
                  ? (constraints.maxWidth - 680) / 2
                  : 16.0;
              return ReorderableListView.builder(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  16,
                  horizontalPadding,
                  96,
                ),
                itemCount: notebooks.length,
                buildDefaultDragHandles: false,
                onReorderItem: manual
                    ? (oldIndex, newIndex) =>
                          _reorder(notebooks, oldIndex, newIndex)
                    : (_, _) {},
                itemBuilder: (context, index) {
                  final notebook = notebooks[index];
                  return Padding(
                    key: ValueKey(notebook.id),
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _NotebookCard(
                      notebook: notebook,
                      manualSort: manual,
                      index: index,
                      onOpen: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => NotebookTextsPage(
                            notebook: notebook,
                            textRepository: widget.textRepository,
                            filePicker: widget.filePicker,
                          ),
                        ),
                      ),
                      onEdit: () => _openForm(notebook),
                      onDelete: () => _confirmDelete(notebook),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openForm,
        icon: const Icon(Icons.add),
        label: const Text('Novo caderno'),
      ),
    );
  }
}

class _NotebookCard extends StatelessWidget {
  const _NotebookCard({
    required this.notebook,
    required this.manualSort,
    required this.index,
    required this.onOpen,
    required this.onEdit,
    required this.onDelete,
  });

  final Notebook notebook;
  final bool manualSort;
  final int index;
  final VoidCallback onOpen;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onOpen,
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(width: 7, color: Color(notebook.colorValue)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 4, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notebook.name,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      if (notebook.description.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          notebook.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      const SizedBox(height: 10),
                      Text(
                        'Ver textos',
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              if (manualSort)
                ReorderableDragStartListener(
                  index: index,
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.drag_handle),
                  ),
                ),
              PopupMenuButton<String>(
                tooltip: 'Ações do caderno',
                onSelected: (value) {
                  if (value == 'edit') onEdit();
                  if (value == 'delete') onDelete();
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: 'edit',
                    child: ListTile(
                      leading: Icon(Icons.edit_outlined),
                      title: Text('Editar'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: ListTile(
                      leading: Icon(Icons.delete_outline),
                      title: Text('Excluir'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MessageState extends StatelessWidget {
  const _MessageState({
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 72, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 20),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(message, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
