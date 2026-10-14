import '../../texts/domain/dialogue.dart';

const aiGenerationInputLimit = 6000;
const aiGenerationPromptVersion = 'lingo-notes-dialogue-v1';

enum AiProvider {
  openAi('openai'),
  anthropic('anthropic');

  const AiProvider(this.apiValue);

  final String apiValue;
}

enum AiConversionMode {
  preserveText('preserveText'),
  adaptAsDialogue('adaptAsDialogue');

  const AiConversionMode(this.apiValue);

  final String apiValue;
}

enum AiGenerationStatus {
  previewReady('previewReady'),
  confirmed('confirmed'),
  failed('failed');

  const AiGenerationStatus(this.apiValue);

  final String apiValue;
}

class AiProviderProfile {
  const AiProviderProfile({
    required this.id,
    required this.provider,
    required this.label,
    required this.promptVersion,
  });

  final String id;
  final AiProvider provider;
  final String label;
  final String promptVersion;
}

class AiGenerationRequest {
  AiGenerationRequest({
    required this.profileId,
    required this.mode,
    required this.title,
    required this.sourceText,
    this.sourceFileName,
  }) {
    if (profileId.trim().isEmpty) {
      throw const AiGenerationInputException('Selecione um perfil de IA.');
    }
    if (title.trim().isEmpty) {
      throw const AiGenerationInputException('Informe um título.');
    }
    if (sourceText.trim().isEmpty) {
      throw const AiGenerationInputException('Informe um texto em inglês.');
    }
    if (sourceText.length > aiGenerationInputLimit) {
      throw const AiGenerationInputException(
        'O texto deve ter no máximo 6.000 caracteres. Recorte o conteúdo.',
      );
    }
  }

  final String profileId;
  final AiConversionMode mode;
  final String title;
  final String sourceText;
  final String? sourceFileName;

  Map<String, dynamic> toApiJson() => {
    'profileId': profileId,
    'mode': mode.apiValue,
    'title': title.trim(),
    'sourceText': sourceText,
    if (sourceFileName != null) 'sourceFileName': sourceFileName,
  };
}

class AiGenerationResult {
  const AiGenerationResult({
    required this.generationId,
    required this.status,
    required this.provider,
    required this.profileId,
    required this.profileLabel,
    required this.promptVersion,
    required this.generatedAt,
    required this.document,
    required this.sourceJson,
  });

  final String generationId;
  final AiGenerationStatus status;
  final AiProvider provider;
  final String profileId;
  final String profileLabel;
  final String promptVersion;
  final DateTime generatedAt;
  final DialogueDocument document;
  final String sourceJson;
}

class AiGenerationMetadata {
  const AiGenerationMetadata({
    required this.generationId,
    required this.provider,
    required this.profileId,
    required this.profileLabel,
    required this.promptVersion,
    required this.generatedAt,
    required this.status,
    this.notebookId,
  });

  factory AiGenerationMetadata.fromResult(AiGenerationResult result) {
    return AiGenerationMetadata(
      generationId: result.generationId,
      provider: result.provider,
      profileId: result.profileId,
      profileLabel: result.profileLabel,
      promptVersion: result.promptVersion,
      generatedAt: result.generatedAt,
      status: result.status,
    );
  }

  final String generationId;
  final AiProvider provider;
  final String profileId;
  final String profileLabel;
  final String promptVersion;
  final DateTime generatedAt;
  final AiGenerationStatus status;
  final String? notebookId;

  AiGenerationMetadata confirmedIn(String targetNotebookId) {
    return AiGenerationMetadata(
      generationId: generationId,
      provider: provider,
      profileId: profileId,
      profileLabel: profileLabel,
      promptVersion: promptVersion,
      generatedAt: generatedAt,
      status: AiGenerationStatus.confirmed,
      notebookId: targetNotebookId,
    );
  }
}

class AiGenerationInputException implements Exception {
  const AiGenerationInputException(this.message);

  final String message;

  @override
  String toString() => message;
}
