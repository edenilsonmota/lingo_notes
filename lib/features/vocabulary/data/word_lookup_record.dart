import 'package:isar_community/isar.dart';

import '../domain/word_lookup.dart';

part 'word_lookup_record.g.dart';

@collection
class WordLookupRecord {
  Id id = Isar.autoIncrement;

  @Index(unique: true, caseSensitive: true)
  late String normalizedWord;

  late String word;
  late String translation;
  late String translationSource;
  late DateTime fetchedAt;

  WordLookupResult toDomain() {
    return WordLookupResult(
      word: word,
      normalizedWord: normalizedWord,
      translation: translation,
      translationSource: translationSource,
      fetchedAt: fetchedAt,
    );
  }

  static WordLookupRecord fromDomain(
    WordLookupResult result, {
    Id? databaseId,
  }) {
    return WordLookupRecord()
      ..id = databaseId ?? Isar.autoIncrement
      ..word = result.word
      ..normalizedWord = result.normalizedWord
      ..translation = result.translation
      ..translationSource = result.translationSource
      ..fetchedAt = result.fetchedAt;
  }
}
