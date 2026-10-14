import 'word_lookup.dart';

abstract interface class WordLookupRepository {
  Future<WordLookupResult> lookup(String word);
}

abstract interface class WordLookupCache {
  Future<WordLookupResult?> find(String normalizedWord);

  Future<void> save(WordLookupResult result);
}

abstract interface class WordLookupRemoteSource {
  Future<WordLookupResult> fetch(String normalizedWord);
}
