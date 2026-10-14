import 'dart:convert';

import 'package:uuid/uuid.dart';

import '../../texts/domain/dialogue_parser.dart';
import '../domain/ai_generation.dart';
import '../domain/ai_generation_gateway.dart';

class SimulatedAiGenerationGateway implements AiGenerationGateway {
  SimulatedAiGenerationGateway({
    List<AiProviderProfile>? configuredProfiles,
    DateTime Function()? now,
  }) : _configuredProfiles = configuredProfiles ?? _defaultProfiles,
       _now = now ?? DateTime.now;

  static const _uuid = Uuid();
  static const _parser = DialogueParser();
  static const _defaultProfiles = [
    AiProviderProfile(
      id: 'openai-economy',
      provider: AiProvider.openAi,
      label: 'Econômico',
      promptVersion: aiGenerationPromptVersion,
    ),
    AiProviderProfile(
      id: 'anthropic-quality',
      provider: AiProvider.anthropic,
      label: 'Melhor qualidade',
      promptVersion: aiGenerationPromptVersion,
    ),
  ];

  final List<AiProviderProfile> _configuredProfiles;
  final DateTime Function() _now;

  @override
  Future<List<AiProviderProfile>> availableProfiles() async {
    return List.unmodifiable(_configuredProfiles);
  }

  @override
  Future<AiGenerationResult> generate(AiGenerationRequest request) async {
    final profile = _configuredProfiles
        .where((item) => item.id == request.profileId)
        .firstOrNull;
    if (profile == null) {
      throw const AiGenerationInputException(
        'O perfil selecionado não está configurado no servidor.',
      );
    }

    final generationId = _uuid.v4();
    final source = _buildDocument(request, generationId);
    final sourceJson = jsonEncode(source);
    final document = _parser.parse(sourceJson);
    return AiGenerationResult(
      generationId: generationId,
      status: AiGenerationStatus.previewReady,
      provider: profile.provider,
      profileId: profile.id,
      profileLabel: profile.label,
      promptVersion: profile.promptVersion,
      generatedAt: _now().toUtc(),
      document: document,
      sourceJson: sourceJson,
    );
  }

  Map<String, dynamic> _buildDocument(
    AiGenerationRequest request,
    String generationId,
  ) {
    final sourceLines = request.sourceText
        .split(RegExp(r'\r?\n'))
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();
    final lines = sourceLines.isEmpty
        ? [request.sourceText.trim()]
        : sourceLines;
    final entries = request.mode == AiConversionMode.adaptAsDialogue
        ? _adaptAsDialogue(lines)
        : _preserve(lines);
    final hasSpeaker = entries.any((entry) => entry.speaker != null);

    return {
      'format': 'english-notebook-dialogue',
      'version': '1.0',
      'id': 'ai-$generationId',
      'title': request.title.trim(),
      'contentType': hasSpeaker ? 'dialogue' : 'narrative',
      'sourceLanguage': 'en-US',
      'targetLanguage': 'pt-BR',
      'tags': ['generated-with-ai'],
      'lines': [
        for (var index = 0; index < entries.length; index++)
          _lineJson(entries[index], index),
      ],
    };
  }

  List<_SourceEntry> _preserve(List<String> lines) {
    final speakerPattern = RegExp(r'^([^:]{1,40}):\s*(.+)$');
    return [
      for (final line in lines)
        if (speakerPattern.firstMatch(line) case final match?)
          _SourceEntry(
            speaker: match.group(1)!.trim(),
            english: match.group(2)!.trim(),
          )
        else
          _SourceEntry(english: line),
    ];
  }

  List<_SourceEntry> _adaptAsDialogue(List<String> lines) {
    return [
      for (var index = 0; index < lines.length; index++)
        _SourceEntry(
          speaker: index.isEven ? 'Speaker A' : 'Speaker B',
          english: lines[index],
        ),
    ];
  }

  Map<String, dynamic> _lineJson(_SourceEntry entry, int index) {
    final segmentId = 's${index + 1}';
    return {
      'id': 'line-${index + 1}',
      if (entry.speaker != null) 'speaker': entry.speaker,
      'segments': [
        {
          'id': segmentId,
          'en': entry.english,
          'pt': '[Prévia simulada] ${entry.english}',
        },
      ],
      'en': [
        {'segmentId': segmentId},
      ],
      'pt': [
        {'segmentId': segmentId},
      ],
    };
  }
}

class _SourceEntry {
  const _SourceEntry({required this.english, this.speaker});

  final String english;
  final String? speaker;
}
