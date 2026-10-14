import 'package:isar_community/isar.dart';
import 'package:uuid/uuid.dart';

import '../domain/vocabulary_entry.dart';
import '../domain/vocabulary_repository.dart';
import 'vocabulary_entry_record.dart';

class IsarVocabularyRepository implements VocabularyRepository {
  IsarVocabularyRepository(this._isar);

  final Isar _isar;
  static const _uuid = Uuid();

  @override
  Stream<List<VocabularyEntry>> watchAll() {
    return _isar.vocabularyEntryRecords
        .where()
        .watch(fireImmediately: true)
        .map((records) {
          final entries = records.map((record) => record.toDomain()).toList();
          entries.sort((a, b) => a.normalizedWord.compareTo(b.normalizedWord));
          return entries;
        });
  }

  @override
  Future<VocabularyEntry> saveWord({
    required String word,
    required String meaning,
    String? meaningSource,
    required String sourceTextId,
  }) async {
    final normalizedWord = normalizeVocabularyWord(word);
    if (normalizedWord.isEmpty) {
      throw ArgumentError.value(word, 'word', 'A palavra não pode ser vazia.');
    }

    late VocabularyEntry saved;
    await _isar.writeTxn(() async {
      final existingRecord = await _isar.vocabularyEntryRecords
          .filter()
          .normalizedWordEqualTo(normalizedWord)
          .findFirst();
      saved = createOrMergeVocabularyEntry(
        id: existingRecord?.uuid ?? _uuid.v4(),
        word: word,
        meaning: meaning,
        meaningSource: meaningSource,
        sourceTextId: sourceTextId,
        now: DateTime.now(),
        existing: existingRecord?.toDomain(),
      );
      await _isar.vocabularyEntryRecords.put(
        VocabularyEntryRecord.fromDomain(saved, databaseId: existingRecord?.id),
      );
    });
    return saved;
  }

  @override
  Future<void> updateStatus(String id, VocabularyStatus status) async {
    final record = await _isar.vocabularyEntryRecords
        .filter()
        .uuidEqualTo(id)
        .findFirst();
    if (record == null) return;

    record
      ..status = status.name
      ..updatedAt = DateTime.now().toUtc();
    await _isar.writeTxn(() async {
      await _isar.vocabularyEntryRecords.put(record);
    });
  }
}
