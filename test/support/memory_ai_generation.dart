import 'package:lingo_notes/features/ai_generation/domain/ai_generation.dart';
import 'package:lingo_notes/features/ai_generation/domain/ai_generation_gateway.dart';
import 'package:lingo_notes/features/ai_generation/domain/ai_source_file_picker.dart';

class MemoryAiGenerationMetadataRepository
    implements AiGenerationMetadataRepository {
  final saved = <AiGenerationMetadata>[];

  @override
  Future<void> save(AiGenerationMetadata metadata) async {
    saved.removeWhere((item) => item.generationId == metadata.generationId);
    saved.add(metadata);
  }
}

class CancelledAiSourceFilePicker implements AiSourceFilePicker {
  const CancelledAiSourceFilePicker();

  @override
  Future<PickedAiSourceFile?> pickTextOrMarkdown() async => null;
}
