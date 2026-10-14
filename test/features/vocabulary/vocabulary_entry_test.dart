import 'package:flutter_test/flutter_test.dart';
import 'package:lingo_notes/features/vocabulary/domain/vocabulary_entry.dart';

void main() {
  test('normaliza caixa, espaços, pontuação externa e apóstrofo', () {
    expect(normalizeVocabularyWord('  “DON’T!”  '), "don't");
    expect(normalizeVocabularyWord('Free   time'), 'free time');
  });

  test('cria palavra nova como não avaliada', () {
    final now = DateTime.utc(2026, 10, 14);
    final entry = createOrMergeVocabularyEntry(
      id: 'word-1',
      word: 'Hello!',
      meaning: 'Olá',
      sourceTextId: 'text-1',
      now: now,
    );

    expect(entry.normalizedWord, 'hello');
    expect(entry.status, VocabularyStatus.unreviewed);
    expect(entry.savedAt, now);
    expect(entry.sourceTextIds, ['text-1']);
  });

  test('mescla duplicata sem perder estado, data ou origens', () {
    final savedAt = DateTime.utc(2026, 10, 13);
    final existing = VocabularyEntry(
      id: 'word-1',
      word: "Don't",
      normalizedWord: "don't",
      meaning: 'Não faça',
      status: VocabularyStatus.learning,
      savedAt: savedAt,
      updatedAt: savedAt,
      sourceTextIds: const ['text-1'],
    );

    final merged = createOrMergeVocabularyEntry(
      id: 'ignored',
      word: 'DON’T!',
      meaning: '',
      sourceTextId: 'text-2',
      now: DateTime.utc(2026, 10, 14),
      existing: existing,
    );

    expect(merged.id, existing.id);
    expect(merged.status, VocabularyStatus.learning);
    expect(merged.savedAt, savedAt);
    expect(merged.meaning, existing.meaning);
    expect(merged.sourceTextIds, ['text-1', 'text-2']);
  });

  test('não sobrescreve uma correção manual com tradução automática', () {
    final date = DateTime.utc(2026, 10, 14);
    final existing = VocabularyEntry(
      id: 'word-1',
      word: 'book',
      normalizedWord: 'book',
      meaning: 'livro corrigido',
      meaningSource: 'manual',
      status: VocabularyStatus.known,
      savedAt: date,
      updatedAt: date,
      sourceTextIds: const ['text-1'],
    );

    final merged = createOrMergeVocabularyEntry(
      id: 'ignored',
      word: 'book',
      meaning: 'reservar',
      meaningSource: 'mymemory',
      sourceTextId: 'text-2',
      now: date.add(const Duration(days: 1)),
      existing: existing,
    );

    expect(merged.meaning, 'livro corrigido');
    expect(merged.meaningSource, 'manual');
    expect(merged.sourceTextIds, ['text-1', 'text-2']);
  });
}
