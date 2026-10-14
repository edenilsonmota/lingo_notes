import 'dart:async';

import 'package:flutter/material.dart';

import '../../vocabulary/domain/vocabulary_entry.dart';
import '../../vocabulary/domain/vocabulary_repository.dart';
import '../domain/dialogue.dart';
import '../domain/dialogue_reader.dart';
import '../domain/text_to_speech.dart';

class DialogueReaderPage extends StatefulWidget {
  const DialogueReaderPage({
    required this.text,
    required this.textToSpeech,
    required this.vocabularyRepository,
    super.key,
  });

  final ImportedText text;
  final TextToSpeech textToSpeech;
  final VocabularyRepository vocabularyRepository;

  @override
  State<DialogueReaderPage> createState() => _DialogueReaderPageState();
}

class _DialogueReaderPageState extends State<DialogueReaderPage> {
  static final _wordPattern = RegExp(r"^[A-Za-z]+(?:['’][A-Za-z]+)*$");
  static final _partPattern = RegExp(r"[A-Za-z]+(?:['’][A-Za-z]+)*|[^A-Za-z]+");

  List<SpeechVoice> _voices = const [];
  SpeechVoice? _voice;
  double _rate = 0.45;
  bool _showTranslation = true;
  bool _speaking = false;
  String? _selectedLineId;
  String? _selectedSegmentId;
  late final Stream<List<VocabularyEntry>> _vocabularyEntries;

  DialogueDocument get _dialogue => widget.text.dialogue;

  @override
  void initState() {
    super.initState();
    _vocabularyEntries = widget.vocabularyRepository.watchAll();
    _loadVoices();
  }

  @override
  void dispose() {
    unawaited(widget.textToSpeech.stop());
    super.dispose();
  }

  Future<void> _loadVoices() async {
    try {
      final voices = await widget.textToSpeech.getEnglishVoices();
      if (!mounted) return;
      final preferred = voices.where((voice) => voice.locale == 'en-US');
      setState(() {
        _voices = voices;
        _voice = preferred.isNotEmpty ? preferred.first : voices.firstOrNull;
      });
    } on Object {
      // The system default en-US voice remains usable when enumeration fails.
    }
  }

  Future<void> _speak(String text) async {
    if (text.trim().isEmpty) return;
    setState(() => _speaking = true);
    try {
      await widget.textToSpeech.speak(text, rate: _rate, voice: _voice);
    } on Object {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Não foi possível reproduzir o áudio em inglês.'),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _speaking = false);
    }
  }

  Future<void> _stop() async {
    await widget.textToSpeech.stop();
    if (mounted) setState(() => _speaking = false);
  }

  void _selectSegment(String lineId, String segmentId) {
    setState(() {
      _selectedLineId = lineId;
      _selectedSegmentId = segmentId;
    });
  }

  Future<void> _showWordActions(String word, VocabularyEntry? existing) async {
    var meaning = existing?.meaning ?? '';
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (sheetContext) => SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            24,
            4,
            24,
            24 + MediaQuery.viewInsetsOf(sheetContext).bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      word,
                      style: Theme.of(sheetContext).textTheme.headlineSmall,
                    ),
                  ),
                  if (existing != null)
                    Chip(
                      avatar: Icon(
                        _vocabularyStatusIcon(existing.status),
                        size: 18,
                        color: _vocabularyStatusColor(
                          sheetContext,
                          existing.status,
                        ),
                      ),
                      label: Text(existing.status.label),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: meaning,
                decoration: const InputDecoration(
                  labelText: 'Significado em português',
                  hintText: 'Opcional',
                ),
                textCapitalization: TextCapitalization.sentences,
                autofocus: existing == null,
                onChanged: (value) => meaning = value,
              ),
              const SizedBox(height: 12),
              const ListTile(
                enabled: false,
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.search),
                title: Text('Consultar palavra'),
                subtitle: Text(
                  'Consultas externas não fazem parte desta etapa',
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () async {
                    try {
                      await widget.vocabularyRepository.saveWord(
                        word: word,
                        meaning: meaning,
                        sourceTextId: widget.text.id,
                      );
                      if (!mounted || !sheetContext.mounted) return;
                      Navigator.of(sheetContext).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            existing == null
                                ? 'Palavra salva no vocabulário.'
                                : 'Palavra atualizada no vocabulário.',
                          ),
                        ),
                      );
                    } on Object {
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Não foi possível salvar a palavra.'),
                        ),
                      );
                    }
                  },
                  icon: Icon(
                    existing == null
                        ? Icons.bookmark_add_outlined
                        : Icons.save_outlined,
                  ),
                  label: Text(
                    existing == null
                        ? 'Salvar no vocabulário'
                        : 'Atualizar significado',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showSpeechSettings() async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, modalSetState) => SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              24,
              4,
              24,
              24 + MediaQuery.viewInsetsOf(context).bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Voz e velocidade',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                if (_voices.isEmpty)
                  const ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.record_voice_over_outlined),
                    title: Text('Voz padrão do sistema'),
                    subtitle: Text('Inglês dos Estados Unidos (en-US)'),
                  )
                else
                  DropdownButtonFormField<SpeechVoice>(
                    initialValue: _voice,
                    isExpanded: true,
                    decoration: const InputDecoration(labelText: 'Voz inglesa'),
                    items: [
                      for (final voice in _voices)
                        DropdownMenuItem(
                          value: voice,
                          child: Text('${voice.name} (${voice.locale})'),
                        ),
                    ],
                    onChanged: (voice) {
                      setState(() => _voice = voice);
                      modalSetState(() {});
                    },
                  ),
                const SizedBox(height: 20),
                Text('Velocidade: ${_rate.toStringAsFixed(2)}'),
                Slider(
                  value: _rate,
                  min: 0.2,
                  max: 0.8,
                  divisions: 12,
                  label: _rate.toStringAsFixed(2),
                  onChanged: (rate) {
                    setState(() => _rate = rate);
                    modalSetState(() {});
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_dialogue.title),
        actions: [
          IconButton(
            tooltip: _showTranslation ? 'Ocultar tradução' : 'Mostrar tradução',
            onPressed: () {
              setState(() => _showTranslation = !_showTranslation);
            },
            icon: Icon(
              _showTranslation ? Icons.translate : Icons.translate_outlined,
            ),
          ),
          IconButton(
            tooltip: 'Configurar voz',
            onPressed: _showSpeechSettings,
            icon: const Icon(Icons.tune),
          ),
          IconButton(
            tooltip: _speaking ? 'Parar áudio' : 'Ouvir texto completo',
            onPressed: _speaking
                ? _stop
                : () => _speak(buildEnglishSpeech(_dialogue)),
            icon: Icon(_speaking ? Icons.stop : Icons.volume_up_outlined),
          ),
        ],
      ),
      body: StreamBuilder<List<VocabularyEntry>>(
        stream: _vocabularyEntries,
        builder: (context, vocabularySnapshot) {
          final entriesByWord = {
            for (final entry
                in vocabularySnapshot.data ?? const <VocabularyEntry>[])
              entry.normalizedWord: entry,
          };
          return LayoutBuilder(
            builder: (context, constraints) {
              final horizontalPadding = constraints.maxWidth > 760
                  ? (constraints.maxWidth - 720) / 2
                  : 16.0;
              return ListView.separated(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  16,
                  horizontalPadding,
                  32,
                ),
                itemCount: _dialogue.lines.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final line = _dialogue.lines[index];
                  return _LineCard(
                    line: line,
                    lineNumber: index + 1,
                    speaking: _speaking,
                    english: Text.rich(
                      TextSpan(
                        children: _spansForLine(
                          context,
                          line,
                          DialogueLanguage.english,
                          (segmentId) => _selectSegment(line.id, segmentId),
                          entriesByWord,
                        ),
                      ),
                    ),
                    portuguese: _showTranslation
                        ? Text.rich(
                            TextSpan(
                              children: _spansForLine(
                                context,
                                line,
                                DialogueLanguage.portuguese,
                                (segmentId) =>
                                    _selectSegment(line.id, segmentId),
                                entriesByWord,
                              ),
                            ),
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                          )
                        : null,
                    onSpeak: () =>
                        _speak(buildLineText(line, DialogueLanguage.english)),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  List<String> _parts(String text) {
    return _partPattern
        .allMatches(text)
        .map((match) => match.group(0)!)
        .toList();
  }

  List<InlineSpan> _spansForLine(
    BuildContext context,
    DialogueLine line,
    DialogueLanguage language,
    ValueChanged<String> onSelectSegment,
    Map<String, VocabularyEntry> entriesByWord,
  ) {
    final baseStyle = Theme.of(context).textTheme.bodyLarge!;
    final spans = <InlineSpan>[];
    for (final token in resolveLineTokens(line, language)) {
      if (!token.isSegment) {
        spans.add(TextSpan(text: token.text, style: baseStyle));
        continue;
      }

      final selected =
          line.id == _selectedLineId && token.segmentId == _selectedSegmentId;
      final style = baseStyle.copyWith(
        decoration: TextDecoration.underline,
        decorationStyle: TextDecorationStyle.dotted,
        backgroundColor: selected
            ? Theme.of(context).colorScheme.primaryContainer
            : Colors.transparent,
        fontWeight: selected ? FontWeight.w700 : null,
      );

      final parts = _parts(token.text);
      for (var partIndex = 0; partIndex < parts.length; partIndex++) {
        final part = parts[partIndex];
        final isWord = _wordPattern.hasMatch(part);
        final vocabularyEntry = language == DialogueLanguage.english && isWord
            ? entriesByWord[normalizeVocabularyWord(part)]
            : null;
        final wordStyle = vocabularyEntry == null
            ? style
            : style.copyWith(
                color: _vocabularyStatusColor(context, vocabularyEntry.status),
                backgroundColor: selected
                    ? Theme.of(context).colorScheme.primaryContainer
                    : _vocabularyStatusColor(
                        context,
                        vocabularyEntry.status,
                      ).withValues(alpha: 0.14),
                fontWeight: FontWeight.w700,
              );
        spans.add(
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onSelectSegment(token.segmentId!),
              onLongPress: language == DialogueLanguage.english && isWord
                  ? () => _showWordActions(part, vocabularyEntry)
                  : null,
              child: Text(
                part,
                key: ValueKey(
                  'segment-${language.name}-${line.id}-${token.segmentId}-$partIndex',
                ),
                style: wordStyle,
                semanticsLabel: vocabularyEntry == null
                    ? null
                    : '$part, ${vocabularyEntry.status.label}',
              ),
            ),
          ),
        );
      }
    }
    return spans;
  }
}

Color _vocabularyStatusColor(BuildContext context, VocabularyStatus status) {
  return switch (status) {
    VocabularyStatus.unreviewed => Theme.of(
      context,
    ).colorScheme.onSurfaceVariant,
    VocabularyStatus.learning => Theme.of(context).colorScheme.error,
    VocabularyStatus.known => const Color(0xFF247A45),
  };
}

IconData _vocabularyStatusIcon(VocabularyStatus status) {
  return switch (status) {
    VocabularyStatus.unreviewed => Icons.circle_outlined,
    VocabularyStatus.learning => Icons.error_outline,
    VocabularyStatus.known => Icons.check_circle_outline,
  };
}

class _LineCard extends StatelessWidget {
  const _LineCard({
    required this.line,
    required this.lineNumber,
    required this.speaking,
    required this.english,
    required this.portuguese,
    required this.onSpeak,
  });

  final DialogueLine line;
  final int lineNumber;
  final bool speaking;
  final Widget english;
  final Widget? portuguese;
  final VoidCallback onSpeak;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 8, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    line.speaker ?? 'Linha $lineNumber',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: 'Ouvir esta linha',
                  onPressed: speaking ? null : onSpeak,
                  icon: const Icon(Icons.volume_up_outlined),
                ),
              ],
            ),
            english,
            if (portuguese != null) ...[
              const SizedBox(height: 12),
              portuguese!,
            ],
          ],
        ),
      ),
    );
  }
}
