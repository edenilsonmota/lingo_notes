import 'package:flutter/material.dart';

import '../../notebooks/domain/notebook.dart';
import '../domain/dialogue.dart';
import '../domain/dialogue_file_picker.dart';
import '../domain/dialogue_parser.dart';
import '../domain/import_dialogue_file.dart';
import '../domain/text_repository.dart';

class NotebookTextsPage extends StatefulWidget {
  const NotebookTextsPage({
    required this.notebook,
    required this.textRepository,
    required this.filePicker,
    super.key,
  });

  final Notebook notebook;
  final TextRepository textRepository;
  final DialogueFilePicker filePicker;

  @override
  State<NotebookTextsPage> createState() => _NotebookTextsPageState();
}

class _NotebookTextsPageState extends State<NotebookTextsPage> {
  late final Stream<List<ImportedText>> _texts;
  late final ImportDialogueFile _importDialogue;
  bool _importing = false;

  @override
  void initState() {
    super.initState();
    _texts = widget.textRepository.watchByNotebook(widget.notebook.id);
    _importDialogue = ImportDialogueFile(widget.textRepository);
  }

  Future<void> _import() async {
    if (_importing) return;
    setState(() => _importing = true);

    try {
      final file = await widget.filePicker.pickJson();
      if (file == null) return;

      final dialogue = await _importDialogue(
        notebookId: widget.notebook.id,
        file: file,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('“${dialogue.title}” foi importado.')),
      );
    } on DialogueValidationException catch (error) {
      if (mounted) await _showValidationErrors(error.issues);
    } on Object {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Não foi possível ler ou importar o arquivo.'),
        ),
      );
    } finally {
      if (mounted) setState(() => _importing = false);
    }
  }

  Future<void> _showValidationErrors(
    List<DialogueValidationIssue> issues,
  ) async {
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Arquivo inválido'),
        content: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Corrija os problemas abaixo e tente importar novamente:',
                ),
                const SizedBox(height: 12),
                for (final issue in issues)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text('• ${issue.path}: ${issue.message}'),
                  ),
              ],
            ),
          ),
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Entendi'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.notebook.name)),
      body: StreamBuilder<List<ImportedText>>(
        stream: _texts,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const _TextState(
              icon: Icons.error_outline,
              title: 'Não foi possível carregar os textos',
              message: 'Feche e abra o caderno para tentar novamente.',
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final texts = snapshot.data!;
          if (texts.isEmpty) {
            return _TextState(
              icon: Icons.article_outlined,
              iconColor: Color(widget.notebook.colorValue),
              title: 'Nenhum texto neste caderno',
              message: 'Importe um arquivo JSON no formato Lingo Notes v1.0.',
            );
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              final horizontalPadding = constraints.maxWidth > 700
                  ? (constraints.maxWidth - 680) / 2
                  : 16.0;
              return ListView.separated(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  16,
                  horizontalPadding,
                  96,
                ),
                itemCount: texts.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (context, index) => _TextCard(text: texts[index]),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _importing ? null : _import,
        icon: _importing
            ? const SizedBox.square(
                dimension: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.upload_file_outlined),
        label: Text(_importing ? 'Importando...' : 'Importar JSON'),
      ),
    );
  }
}

class _TextCard extends StatelessWidget {
  const _TextCard({required this.text});

  final ImportedText text;

  @override
  Widget build(BuildContext context) {
    final dialogue = text.dialogue;
    final type = dialogue.contentType == DialogueContentType.dialogue
        ? 'Diálogo'
        : 'Narrativa';
    final details = [
      type,
      '${dialogue.lines.length} ${dialogue.lines.length == 1 ? 'linha' : 'linhas'}',
      if (dialogue.level != null && dialogue.level!.isNotEmpty) dialogue.level!,
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.article_outlined),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    dialogue.title,
                    style: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              details.join(' • '),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            if (dialogue.tags.isNotEmpty) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (final tag in dialogue.tags)
                    Chip(
                      label: Text(tag),
                      visualDensity: VisualDensity.compact,
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _TextState extends StatelessWidget {
  const _TextState({
    required this.icon,
    required this.title,
    required this.message,
    this.iconColor,
  });

  final IconData icon;
  final Color? iconColor;
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
            Icon(
              icon,
              size: 64,
              color: iconColor ?? Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
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
