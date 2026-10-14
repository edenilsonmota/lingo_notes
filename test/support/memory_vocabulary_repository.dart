import 'dart:async';

import 'package:lingo_notes/features/vocabulary/domain/vocabulary_entry.dart';
import 'package:lingo_notes/features/vocabulary/domain/vocabulary_repository.dart';

class MemoryVocabularyRepository implements VocabularyRepository {
  MemoryVocabularyRepository([Iterable<VocabularyEntry> initial = const []])
    : entries = List.of(initial);

  final List<VocabularyEntry> entries;
  final _changes = StreamController<List<VocabularyEntry>>.broadcast();
  int _nextId = 1;

  @override
  Stream<List<VocabularyEntry>> watchAll() async* {
    yield _sortedEntries();
    yield* _changes.stream;
  }

  @override
  Future<VocabularyEntry> saveWord({
    required String word,
    required String meaning,
    String? meaningSource,
    required String sourceTextId,
  }) async {
    final normalized = normalizeVocabularyWord(word);
    final existingIndex = entries.indexWhere(
      (entry) => entry.normalizedWord == normalized,
    );
    final existing = existingIndex < 0 ? null : entries[existingIndex];
    final saved = createOrMergeVocabularyEntry(
      id: existing?.id ?? 'word-${_nextId++}',
      word: word,
      meaning: meaning,
      meaningSource: meaningSource,
      sourceTextId: sourceTextId,
      now: DateTime.utc(2026, 10, 14, 12, _nextId),
      existing: existing,
    );
    if (existingIndex < 0) {
      entries.add(saved);
    } else {
      entries[existingIndex] = saved;
    }
    _emit();
    return saved;
  }

  @override
  Future<void> updateStatus(String id, VocabularyStatus status) async {
    final index = entries.indexWhere((entry) => entry.id == id);
    if (index < 0) return;
    entries[index] = entries[index].copyWith(
      status: status,
      updatedAt: DateTime.utc(2026, 10, 14, 13, _nextId++),
    );
    _emit();
  }

  List<VocabularyEntry> _sortedEntries() {
    return List.of(entries)
      ..sort((a, b) => a.normalizedWord.compareTo(b.normalizedWord));
  }

  void _emit() => _changes.add(_sortedEntries());

  Future<void> dispose() => _changes.close();
}
