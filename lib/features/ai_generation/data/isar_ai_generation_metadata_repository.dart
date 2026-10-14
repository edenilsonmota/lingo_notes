import 'package:isar_community/isar.dart';

import '../domain/ai_generation.dart';
import '../domain/ai_generation_gateway.dart';
import 'ai_generation_record.dart';

class IsarAiGenerationMetadataRepository
    implements AiGenerationMetadataRepository {
  IsarAiGenerationMetadataRepository(this._isar);

  final Isar _isar;

  @override
  Future<void> save(AiGenerationMetadata metadata) async {
    final existing = await _isar.aiGenerationRecords
        .filter()
        .generationIdEqualTo(metadata.generationId)
        .findFirst();
    final record = AiGenerationRecord.fromDomain(
      metadata,
      databaseId: existing?.id,
    );
    await _isar.writeTxn(() async {
      await _isar.aiGenerationRecords.put(record);
    });
  }
}
