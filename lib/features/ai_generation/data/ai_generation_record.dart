import 'package:isar_community/isar.dart';

import '../domain/ai_generation.dart';

part 'ai_generation_record.g.dart';

@collection
class AiGenerationRecord {
  Id id = Isar.autoIncrement;

  @Index(unique: true, caseSensitive: true)
  late String generationId;

  late String provider;
  late String profileId;
  late String profileLabel;
  late String promptVersion;
  late DateTime generatedAt;
  late String status;
  String? notebookId;

  static AiGenerationRecord fromDomain(
    AiGenerationMetadata metadata, {
    Id? databaseId,
  }) {
    return AiGenerationRecord()
      ..id = databaseId ?? Isar.autoIncrement
      ..generationId = metadata.generationId
      ..provider = metadata.provider.apiValue
      ..profileId = metadata.profileId
      ..profileLabel = metadata.profileLabel
      ..promptVersion = metadata.promptVersion
      ..generatedAt = metadata.generatedAt
      ..status = metadata.status.apiValue
      ..notebookId = metadata.notebookId;
  }
}
