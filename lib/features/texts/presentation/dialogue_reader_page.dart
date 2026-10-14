import 'dart:async';

import 'package:flutter/material.dart';

import '../domain/dialogue.dart';
import '../domain/dialogue_reader.dart';
import '../domain/text_to_speech.dart';

class DialogueReaderPage extends StatefulWidget {
  const DialogueReaderPage({
    required this.text,
    required this.textToSpeech,
    super.key,
  });

  final ImportedText text;
  final TextToSpeech textToSpeech;

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

  DialogueDocument get _dialogue => widget.text.dialogue;

  @override
  void initState() {
    super.initState();
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

  Future<void> _showWordActions(String word) async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 4, 24, 12),
                child: Text(
                  word,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              const ListTile(
                enabled: false,
                leading: Icon(Icons.search),
                title: Text('Consultar palavra'),
                subtitle: Text('Disponível na etapa de vocabulário'),
              ),
              const ListTile(
                enabled: false,
                leading: Icon(Icons.bookmark_add_outlined),
                title: Text('Salvar no vocabulário'),
                subtitle: Text('Disponível na etapa de vocabulário'),
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
      body: LayoutBuilder(
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
                      _showWordActions,
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
                            (segmentId) => _selectSegment(line.id, segmentId),
                            _showWordActions,
                          ),
                        ),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      )
                    : null,
                onSpeak: () =>
                    _speak(buildLineText(line, DialogueLanguage.english)),
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
    ValueChanged<String> onLongPressWord,
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
        spans.add(
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onSelectSegment(token.segmentId!),
              onLongPress: language == DialogueLanguage.english && isWord
                  ? () => onLongPressWord(part)
                  : null,
              child: Text(
                part,
                key: ValueKey(
                  'segment-${language.name}-${line.id}-${token.segmentId}-$partIndex',
                ),
                style: style,
              ),
            ),
          ),
        );
      }
    }
    return spans;
  }
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
