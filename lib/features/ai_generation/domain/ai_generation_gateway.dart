import 'ai_generation.dart';

abstract interface class AiGenerationGateway {
  Future<List<AiProviderProfile>> availableProfiles();

  Future<AiGenerationResult> generate(AiGenerationRequest request);
}

abstract interface class AiGenerationMetadataRepository {
  Future<void> save(AiGenerationMetadata metadata);
}
