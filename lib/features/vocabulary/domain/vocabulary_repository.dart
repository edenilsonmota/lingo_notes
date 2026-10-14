import 'vocabulary_entry.dart';

abstract interface class VocabularyRepository {
  Stream<List<VocabularyEntry>> watchAll();

  Future<VocabularyEntry> saveWord({
    required String word,
    required String meaning,
    String? meaningSource,
    required String sourceTextId,
  });

  Future<void> updateStatus(String id, VocabularyStatus status);
}
