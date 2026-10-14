import 'package:isar_community/isar.dart';

import '../domain/word_lookup.dart';
import '../domain/word_lookup_repository.dart';
import 'word_lookup_record.dart';

class IsarWordLookupCache implements WordLookupCache {
  IsarWordLookupCache(this._isar);

  final Isar _isar;

  @override
  Future<WordLookupResult?> find(String normalizedWord) async {
    final record = await _isar.wordLookupRecords
        .filter()
        .normalizedWordEqualTo(normalizedWord)
        .findFirst();
    return record?.toDomain();
  }

  @override
  Future<void> save(WordLookupResult result) async {
    await _isar.writeTxn(() async {
      final existing = await _isar.wordLookupRecords
          .filter()
          .normalizedWordEqualTo(result.normalizedWord)
          .findFirst();
      await _isar.wordLookupRecords.put(
        WordLookupRecord.fromDomain(result, databaseId: existing?.id),
      );
    });
  }
}
