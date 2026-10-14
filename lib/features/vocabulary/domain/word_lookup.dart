class WordLookupResult {
  const WordLookupResult({
    required this.word,
    required this.normalizedWord,
    required this.translation,
    required this.translationSource,
    required this.fetchedAt,
  });

  final String word;
  final String normalizedWord;
  final String translation;
  final String translationSource;
  final DateTime fetchedAt;
}

enum WordLookupFailure { notFound, network, invalidResponse }

class WordLookupException implements Exception {
  const WordLookupException(this.failure, this.message);

  final WordLookupFailure failure;
  final String message;

  @override
  String toString() => message;
}
