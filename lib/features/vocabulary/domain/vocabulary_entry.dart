enum VocabularyStatus {
  unreviewed,
  learning,
  known;

  String get label => switch (this) {
    VocabularyStatus.unreviewed => 'Não avaliada',
    VocabularyStatus.learning => 'Precisa revisar',
    VocabularyStatus.known => 'Conhecida',
  };

  static VocabularyStatus fromStorage(String value) {
    return VocabularyStatus.values.firstWhere(
      (status) => status.name == value,
      orElse: () => VocabularyStatus.unreviewed,
    );
  }
}

class VocabularyEntry {
  const VocabularyEntry({
    required this.id,
    required this.word,
    required this.normalizedWord,
    required this.meaning,
    required this.status,
    required this.savedAt,
    required this.updatedAt,
    required this.sourceTextIds,
  });

  final String id;
  final String word;
  final String normalizedWord;
  final String meaning;
  final VocabularyStatus status;
  final DateTime savedAt;
  final DateTime updatedAt;
  final List<String> sourceTextIds;

  VocabularyEntry copyWith({
    String? word,
    String? meaning,
    VocabularyStatus? status,
    DateTime? updatedAt,
    List<String>? sourceTextIds,
  }) {
    return VocabularyEntry(
      id: id,
      word: word ?? this.word,
      normalizedWord: normalizedWord,
      meaning: meaning ?? this.meaning,
      status: status ?? this.status,
      savedAt: savedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      sourceTextIds: sourceTextIds ?? this.sourceTextIds,
    );
  }
}

String normalizeVocabularyWord(String word) {
  final apostrophesNormalized = word.trim().replaceAll('’', "'");
  final withoutExternalPunctuation = apostrophesNormalized
      .replaceFirst(RegExp(r"^[^\p{L}\p{N}]+", unicode: true), '')
      .replaceFirst(RegExp(r"[^\p{L}\p{N}]+$", unicode: true), '');
  return withoutExternalPunctuation
      .replaceAll(RegExp(r'\s+'), ' ')
      .toLowerCase();
}

VocabularyEntry createOrMergeVocabularyEntry({
  required String id,
  required String word,
  required String meaning,
  required String sourceTextId,
  required DateTime now,
  VocabularyEntry? existing,
}) {
  final normalizedWord = normalizeVocabularyWord(word);
  if (normalizedWord.isEmpty) {
    throw ArgumentError.value(word, 'word', 'A palavra não pode ser vazia.');
  }

  final trimmedWord = word.trim();
  final trimmedMeaning = meaning.trim();
  if (existing == null) {
    return VocabularyEntry(
      id: id,
      word: trimmedWord,
      normalizedWord: normalizedWord,
      meaning: trimmedMeaning,
      status: VocabularyStatus.unreviewed,
      savedAt: now.toUtc(),
      updatedAt: now.toUtc(),
      sourceTextIds: [sourceTextId],
    );
  }

  final sources = {...existing.sourceTextIds, sourceTextId}.toList()..sort();
  return existing.copyWith(
    meaning: trimmedMeaning.isEmpty ? existing.meaning : trimmedMeaning,
    updatedAt: now.toUtc(),
    sourceTextIds: sources,
  );
}
