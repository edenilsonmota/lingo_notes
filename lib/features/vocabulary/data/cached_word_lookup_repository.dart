import '../domain/vocabulary_entry.dart';
import '../domain/word_lookup.dart';
import '../domain/word_lookup_repository.dart';

class CachedWordLookupRepository implements WordLookupRepository {
  CachedWordLookupRepository({required this.cache, required this.remote});

  final WordLookupCache cache;
  final WordLookupRemoteSource remote;

  @override
  Future<WordLookupResult> lookup(String word) async {
    final normalizedWord = normalizeVocabularyWord(word);
    final isIndividualWord = RegExp(r"^[a-z]+(?:'[a-z]+)*$")
        .hasMatch(normalizedWord);
    if (!isIndividualWord) {
      throw const WordLookupException(
        WordLookupFailure.notFound,
        'Selecione uma palavra inglesa válida.',
      );
    }

    final cached = await cache.find(normalizedWord);
    if (cached != null) return cached;

    final result = await remote.fetch(normalizedWord);
    await cache.save(result);
    return result;
  }
}
