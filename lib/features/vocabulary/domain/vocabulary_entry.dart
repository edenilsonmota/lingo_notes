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
    this.meaningSource,
    required this.status,
    required this.savedAt,
    required this.updatedAt,
    required this.sourceTextIds,
  });

  final String id;
  final String word;
  final String normalizedWord;
  final String meaning;
  final String? meaningSource;
  final VocabularyStatus status;
  final DateTime savedAt;
  final DateTime updatedAt;
  final List<String> sourceTextIds;

  VocabularyEntry copyWith({
    String? word,
    String? meaning,
    String? meaningSource,
    VocabularyStatus? status,
    DateTime? updatedAt,
    List<String>? sourceTextIds,
  }) {
    return VocabularyEntry(
      id: id,
      word: word ?? this.word,
      normalizedWord: normalizedWord,
      meaning: meaning ?? this.meaning,
      meaningSource: meaningSource ?? this.meaningSource,
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
  String? meaningSource,
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
      meaningSource: trimmedMeaning.isEmpty ? null : meaningSource,
      status: VocabularyStatus.unreviewed,
      savedAt: now.toUtc(),
      updatedAt: now.toUtc(),
      sourceTextIds: [sourceTextId],
    );
  }

  final sources = {...existing.sourceTextIds, sourceTextId}.toList()..sort();
  final preserveManualMeaning =
      existing.meaningSource == 'manual' && meaningSource != 'manual';
  return existing.copyWith(
    meaning: trimmedMeaning.isEmpty || preserveManualMeaning
        ? existing.meaning
        : trimmedMeaning,
    meaningSource: trimmedMeaning.isEmpty || preserveManualMeaning
        ? existing.meaningSource
        : meaningSource,
    updatedAt: now.toUtc(),
    sourceTextIds: sources,
  );
}
