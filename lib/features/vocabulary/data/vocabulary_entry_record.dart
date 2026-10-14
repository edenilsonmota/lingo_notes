import 'package:isar_community/isar.dart';

import '../domain/vocabulary_entry.dart';

part 'vocabulary_entry_record.g.dart';

@collection
class VocabularyEntryRecord {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uuid;

  @Index(unique: true, caseSensitive: true)
  late String normalizedWord;

  late String word;
  String meaning = '';
  String? meaningSource;
  String status = VocabularyStatus.unreviewed.name;
  late DateTime savedAt;
  late DateTime updatedAt;
  List<String> sourceTextIds = const [];

  VocabularyEntry toDomain() {
    return VocabularyEntry(
      id: uuid,
      word: word,
      normalizedWord: normalizedWord,
      meaning: meaning,
      meaningSource: meaningSource,
      status: VocabularyStatus.fromStorage(status),
      savedAt: savedAt,
      updatedAt: updatedAt,
      sourceTextIds: List.unmodifiable(sourceTextIds),
    );
  }

  static VocabularyEntryRecord fromDomain(
    VocabularyEntry entry, {
    Id? databaseId,
  }) {
    return VocabularyEntryRecord()
      ..id = databaseId ?? Isar.autoIncrement
      ..uuid = entry.id
      ..word = entry.word
      ..normalizedWord = entry.normalizedWord
      ..meaning = entry.meaning
      ..meaningSource = entry.meaningSource
      ..status = entry.status.name
      ..savedAt = entry.savedAt
      ..updatedAt = entry.updatedAt
      ..sourceTextIds = List.of(entry.sourceTextIds);
  }
}
