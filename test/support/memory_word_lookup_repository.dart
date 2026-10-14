import 'package:lingo_notes/features/vocabulary/domain/word_lookup.dart';
import 'package:lingo_notes/features/vocabulary/domain/word_lookup_repository.dart';

class MemoryWordLookupRepository implements WordLookupRepository {
  MemoryWordLookupRepository({WordLookupResult? result, this.error})
    : result = result ?? sampleWordLookupResult();

  final WordLookupResult result;
  final Object? error;
  final calls = <String>[];

  @override
  Future<WordLookupResult> lookup(String word) async {
    calls.add(word);
    if (error != null) throw error!;
    return result;
  }
}

WordLookupResult sampleWordLookupResult({
  String word = 'what',
  String translation = 'o que',
}) {
  return WordLookupResult(
    word: word,
    normalizedWord: word,
    translation: translation,
    translationSource: 'mymemory',
    fetchedAt: DateTime.utc(2026, 10, 14),
  );
}
