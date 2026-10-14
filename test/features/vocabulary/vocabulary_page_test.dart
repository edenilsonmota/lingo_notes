import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lingo_notes/features/vocabulary/domain/vocabulary_entry.dart';
import 'package:lingo_notes/features/vocabulary/presentation/vocabulary_page.dart';

import '../../support/memory_vocabulary_repository.dart';

void main() {
  testWidgets('filtra palavras pelos estados oficiais', (tester) async {
    final repository = MemoryVocabularyRepository([
      entry('word-1', 'apple', VocabularyStatus.unreviewed),
      entry('word-2', 'book', VocabularyStatus.learning),
      entry('word-3', 'chair', VocabularyStatus.known),
    ]);
    await tester.pumpWidget(vocabularyApp(repository));
    await tester.pumpAndSettle();

    expect(find.text('apple'), findsOneWidget);
    expect(find.text('book'), findsOneWidget);
    expect(find.text('chair'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilterChip, 'Precisa revisar'));
    await tester.pumpAndSettle();

    expect(find.text('apple'), findsNothing);
    expect(find.text('book'), findsOneWidget);
    expect(find.text('chair'), findsNothing);
  });

  testWidgets('altera rapidamente o estado de uma palavra', (tester) async {
    final repository = MemoryVocabularyRepository([
      entry('word-1', 'apple', VocabularyStatus.unreviewed),
    ]);
    await tester.pumpWidget(vocabularyApp(repository));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Conhecida'));
    await tester.pumpAndSettle();

    expect(repository.entries.single.status, VocabularyStatus.known);
  });
}

Widget vocabularyApp(MemoryVocabularyRepository repository) {
  return MaterialApp(home: VocabularyPage(repository: repository));
}

VocabularyEntry entry(String id, String word, VocabularyStatus status) {
  final date = DateTime.utc(2026, 10, 14);
  return VocabularyEntry(
    id: id,
    word: word,
    normalizedWord: word,
    meaning: '',
    status: status,
    savedAt: date,
    updatedAt: date,
    sourceTextIds: const ['text-1'],
  );
}
