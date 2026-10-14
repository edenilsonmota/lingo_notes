import 'package:flutter/material.dart';

import '../../notebooks/domain/notebook.dart';
import '../../notebooks/domain/notebook_repository.dart';
import '../../notebooks/presentation/notebook_form_dialog.dart';
import '../../texts/domain/dialogue.dart';
import '../../texts/domain/dialogue_parser.dart';
import '../../texts/domain/text_repository.dart';
import '../domain/ai_generation.dart';
import '../domain/ai_generation_gateway.dart';
import '../domain/ai_source_file_picker.dart';
import '../domain/update_generated_dialogue_title.dart';

class AiGenerationPage extends StatefulWidget {
  const AiGenerationPage({
    required this.notebookRepository,
    required this.textRepository,
    required this.filePicker,
    required this.gateway,
    required this.metadataRepository,
    super.key,
  });

  final NotebookRepository notebookRepository;
  final TextRepository textRepository;
  final AiSourceFilePicker filePicker;
  final AiGenerationGateway gateway;
  final AiGenerationMetadataRepository metadataRepository;

  @override
  State<AiGenerationPage> createState() => _AiGenerationPageState();
}

class _AiGenerationPageState extends State<AiGenerationPage> {
  static const _newNotebookValue = '__new__';
  static const _parser = DialogueParser();

  final _titleController = TextEditingController();
  final _sourceController = TextEditingController();
  final _newNotebookController = TextEditingController();
  late final Future<List<AiProviderProfile>> _profiles;
  late final Stream<List<Notebook>> _notebooks;
  AiConversionMode _mode = AiConversionMode.preserveText;
  String? _profileId;
  String? _sourceFileName;
  String? _targetNotebookId;
  AiGenerationResult? _preview;
  bool _generating = false;
  bool _saving = false;
  String? _error;
  String? _confirmedNotebookName;

  @override
  void initState() {
    super.initState();
    _profiles = widget.gateway.availableProfiles();
    _notebooks = widget.notebookRepository.watchAll();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _sourceController.dispose();
    _newNotebookController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    try {
      final file = await widget.filePicker.pickTextOrMarkdown();
      if (file == null || !mounted) return;
      if (file.content.length > aiGenerationInputLimit) {
        setState(() {
          _error = 'O arquivo possui mais de 6.000 caracteres. Recorte o conteúdo antes de gerar.';
        });
        return;
      }
      setState(() {
        _sourceController.text = file.content;
        _sourceFileName = file.name;
        _error = null;
      });
    } on Object {
      if (mounted) {
        setState(() {
          _error =
              'Não foi possível ler o arquivo. Use um .txt ou .md em UTF-8.';
        });
      }
    }
  }

  Future<void> _generate() async {
    if (_generating) return;
    setState(() {
      _generating = true;
      _error = null;
    });
    try {
      final request = AiGenerationRequest(
        profileId: _profileId ?? '',
        mode: _mode,
        title: _titleController.text,
        sourceText: _sourceController.text,
        sourceFileName: _sourceFileName,
      );
      final result = await widget.gateway.generate(request);
      _parser.parse(result.sourceJson);
      await widget.metadataRepository.save(
        AiGenerationMetadata.fromResult(result),
      );
      if (!mounted) return;
      setState(() => _preview = result);
    } on AiGenerationInputException catch (error) {
      if (mounted) setState(() => _error = error.message);
    } on DialogueValidationException catch (error) {
      if (mounted) {
        setState(() {
          _error =
              'A prévia simulada falhou na validação: ${error.issues.first}';
        });
      }
    } on Object {
      if (mounted) {
        setState(() => _error = 'Não foi possível gerar a prévia agora.');
      }
    } finally {
      if (mounted) setState(() => _generating = false);
    }
  }

  Future<void> _confirm(List<Notebook> notebooks) async {
    final preview = _preview;
    if (preview == null || _saving) return;
    if (_targetNotebookId == null) {
      setState(() => _error = 'Selecione um caderno ou crie um novo.');
      return;
    }
    if (_targetNotebookId == _newNotebookValue &&
        _newNotebookController.text.trim().isEmpty) {
      setState(() => _error = 'Informe o nome do novo caderno.');
      return;
    }

    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      final Notebook target;
      if (_targetNotebookId == _newNotebookValue) {
        target = await widget.notebookRepository.create(
          name: _newNotebookController.text,
          description: 'Criado pelo modo Gerar com IA',
          colorValue: notebookColors.first,
        );
      } else {
        target = notebooks.firstWhere((item) => item.id == _targetNotebookId);
      }

      final sourceJson = updateGeneratedDialogueTitle(
        sourceJson: preview.sourceJson,
        title: _titleController.text,
      );
      final dialogue = _parser.parse(sourceJson);
      await widget.textRepository.save(
        notebookId: target.id,
        dialogue: dialogue,
        sourceJson: sourceJson,
      );
      await widget.metadataRepository.save(
        AiGenerationMetadata.fromResult(preview).confirmedIn(target.id),
      );
      if (!mounted) return;
      setState(() => _confirmedNotebookName = target.name);
    } on AiGeneratedTitleException catch (error) {
      if (mounted) setState(() => _error = error.message);
    } on Object {
      if (mounted) {
        setState(() => _error = 'Não foi possível salvar o texto gerado.');
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gerar com IA')),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: _confirmedNotebookName != null
              ? _ConfirmationState(
                  notebookName: _confirmedNotebookName!,
                  onClose: () => Navigator.of(context).pop(),
                )
              : _preview == null
              ? _buildInput()
              : _buildPreview(),
        ),
      ),
    );
  }

  Widget _buildInput() {
    return FutureBuilder<List<AiProviderProfile>>(
      future: _profiles,
      builder: (context, snapshot) {
        final profiles = snapshot.data ?? const <AiProviderProfile>[];
        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          children: [
            Card(
              color: Theme.of(context).colorScheme.secondaryContainer,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Prévia simulada: nenhuma chamada real à OpenAI ou Anthropic será feita nesta etapa.',
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _titleController,
              maxLength: 120,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            const SizedBox(height: 12),
            TextField(
              key: const ValueKey('ai-source-text'),
              controller: _sourceController,
              minLines: 8,
              maxLines: 14,
              maxLength: aiGenerationInputLimit,
              buildCounter: (
                context, {
                required currentLength,
                required maxLength,
                required isFocused,
              }) => Text('$currentLength/$aiGenerationInputLimit caracteres'),
              decoration: const InputDecoration(
                labelText: 'Texto em inglês',
                hintText: 'Cole ou digite um texto curto em inglês.',
                alignLabelWithHint: true,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: OutlinedButton.icon(
                onPressed: _pickFile,
                icon: const Icon(Icons.file_open_outlined),
                label: const Text('Importar .txt ou .md'),
              ),
            ),
            if (_sourceFileName != null)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text('Arquivo selecionado: $_sourceFileName'),
              ),
            const SizedBox(height: 20),
            Text('Modo', style: Theme.of(context).textTheme.titleMedium),
            RadioGroup<AiConversionMode>(
              groupValue: _mode,
              onChanged: (value) => setState(() => _mode = value!),
              child: const Column(
                children: [
                  RadioListTile<AiConversionMode>(
                    value: AiConversionMode.preserveText,
                    title: Text('Preservar texto'),
                    subtitle: Text(
                      'Mantém narrativa como narrativa e reconhece falantes já existentes.',
                    ),
                  ),
                  RadioListTile<AiConversionMode>(
                    value: AiConversionMode.adaptAsDialogue,
                    title: Text('Adaptar como diálogo'),
                    subtitle: Text(
                      'Reescrita criativa: pode alterar a forma do texto original.',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            if (snapshot.connectionState != ConnectionState.done)
              const Center(child: CircularProgressIndicator())
            else if (snapshot.hasError)
              const Text('Não foi possível carregar os perfis do servidor.')
            else if (profiles.isEmpty)
              const Text('Nenhum perfil de IA está configurado no servidor.')
            else
              DropdownButtonFormField<String>(
                key: const ValueKey('ai-profile'),
                initialValue: _profileId,
                decoration: const InputDecoration(labelText: 'Perfil'),
                items: [
                  for (final profile in profiles)
                    DropdownMenuItem(
                      value: profile.id,
                      child: Text(
                        '${profile.label} • ${_providerLabel(profile.provider)}',
                      ),
                    ),
                ],
                onChanged: (value) => setState(() => _profileId = value),
              ),
            if (_error != null) _ErrorMessage(_error!),
            const SizedBox(height: 20),
            FilledButton.icon(
              key: const ValueKey('ai-generate'),
              onPressed: profiles.isEmpty || _generating ? null : _generate,
              icon: _generating
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.auto_awesome),
              label: Text(_generating ? 'Gerando...' : 'Gerar prévia'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPreview() {
    final preview = _preview!;
    return StreamBuilder<List<Notebook>>(
      stream: _notebooks,
      builder: (context, snapshot) {
        final notebooks = snapshot.data ?? const <Notebook>[];
        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          children: [
            Text('Prévia', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 6),
            Text(
              '${preview.profileLabel} • ${_providerLabel(preview.provider)}',
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _titleController,
              maxLength: 120,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            const SizedBox(height: 12),
            for (final line in preview.document.lines) _PreviewLine(line: line),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              key: const ValueKey('ai-target-notebook'),
              initialValue: _targetNotebookId,
              decoration: const InputDecoration(labelText: 'Salvar em'),
              items: [
                for (final notebook in notebooks)
                  DropdownMenuItem(
                    value: notebook.id,
                    child: Text(notebook.name),
                  ),
                const DropdownMenuItem(
                  value: _newNotebookValue,
                  child: Text('Criar novo caderno'),
                ),
              ],
              onChanged: (value) => setState(() => _targetNotebookId = value),
            ),
            if (_targetNotebookId == _newNotebookValue) ...[
              const SizedBox(height: 12),
              TextField(
                controller: _newNotebookController,
                maxLength: 80,
                decoration: const InputDecoration(
                  labelText: 'Nome do novo caderno',
                ),
              ),
            ],
            if (_error != null) _ErrorMessage(_error!),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _saving
                        ? null
                        : () => setState(() {
                            _preview = null;
                            _error = null;
                          }),
                    child: const Text('Voltar e editar'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    key: const ValueKey('ai-confirm'),
                    onPressed: _saving || !snapshot.hasData
                        ? null
                        : () => _confirm(notebooks),
                    icon: const Icon(Icons.save_outlined),
                    label: Text(_saving ? 'Salvando...' : 'Confirmar e salvar'),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  String _providerLabel(AiProvider provider) {
    return switch (provider) {
      AiProvider.openAi => 'OpenAI',
      AiProvider.anthropic => 'Anthropic',
    };
  }
}

class _PreviewLine extends StatelessWidget {
  const _PreviewLine({required this.line});

  final DialogueLine line;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (line.speaker != null) ...[
              Text(
                line.speaker!,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 6),
            ],
            for (final segment in line.segments) ...[
              Text(segment.english),
              const SizedBox(height: 4),
              Text(
                segment.portuguese,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ErrorMessage extends StatelessWidget {
  const _ErrorMessage(this.message);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Text(
        message,
        style: TextStyle(color: Theme.of(context).colorScheme.error),
      ),
    );
  }
}

class _ConfirmationState extends StatelessWidget {
  const _ConfirmationState({required this.notebookName, required this.onClose});

  final String notebookName;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 72,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'Texto salvo',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text('A geração foi confirmada no caderno “$notebookName”.'),
            const SizedBox(height: 20),
            FilledButton(onPressed: onClose, child: const Text('Concluir')),
          ],
        ),
      ),
    );
  }
}
