import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lingo_notes/features/texts/domain/dialogue.dart';
import 'package:lingo_notes/features/texts/domain/dialogue_parser.dart';
import 'package:lingo_notes/features/texts/presentation/dialogue_reader_page.dart';
import 'package:lingo_notes/features/vocabulary/domain/vocabulary_entry.dart';

import '../../support/fake_text_to_speech.dart';
import '../../support/memory_vocabulary_repository.dart';
import '../../support/memory_word_lookup_repository.dart';
import 'dialogue_parser_test.dart' show validDialogueJson;

void main() {
  testWidgets('destaca o mesmo segmento nos dois idiomas', (tester) async {
    final speech = FakeTextToSpeech();
    await tester.pumpWidget(readerApp(speech));
    await tester.pumpAndSettle();

    const englishKey = ValueKey('segment-english-line-001-s1-0');
    const portugueseKey = ValueKey('segment-portuguese-line-001-s1-0');
    await tester.tap(find.byKey(englishKey));
    await tester.pump();

    final english = tester.widget<Text>(find.byKey(englishKey));
    final portuguese = tester.widget<Text>(find.byKey(portugueseKey));
    expect(english.style?.backgroundColor, isNot(Colors.transparent));
    expect(portuguese.style?.backgroundColor, english.style?.backgroundColor);

    const englishSecondKey = ValueKey('segment-english-line-001-s2-0');
    const portugueseSecondKey = ValueKey('segment-portuguese-line-001-s2-0');
    await tester.tap(find.byKey(portugueseSecondKey));
    await tester.pump();

    final selectedFromPortuguese = tester.widget<Text>(
      find.byKey(englishSecondKey),
    );
    expect(
      selectedFromPortuguese.style?.backgroundColor,
      isNot(Colors.transparent),
    );
    final previouslySelected = tester.widget<Text>(find.byKey(englishKey));
    expect(previouslySelected.style?.backgroundColor, Colors.transparent);
  });

  testWidgets('oculta e mostra a tradução', (tester) async {
    final speech = FakeTextToSpeech();
    await tester.pumpWidget(readerApp(speech));
    await tester.pumpAndSettle();

    const portugueseKey = ValueKey('segment-portuguese-line-001-s1-0');
    expect(find.byKey(portugueseKey), findsOneWidget);
    await tester.tap(find.byTooltip('Ocultar tradução'));
    await tester.pump();
    expect(find.byKey(portugueseKey), findsNothing);
    await tester.tap(find.byTooltip('Mostrar tradução'));
    await tester.pump();
    expect(find.byKey(portugueseKey), findsOneWidget);
  });

  testWidgets('fala uma linha e o texto completo usando somente inglês', (
    tester,
  ) async {
    final speech = FakeTextToSpeech();
    await tester.pumpWidget(readerApp(speech));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Ouvir esta linha'));
    await tester.pumpAndSettle();
    expect(
      speech.calls.single.text,
      'What do you like to do in your free time?',
    );

    await tester.tap(find.byTooltip('Ouvir texto completo'));
    await tester.pumpAndSettle();
    expect(speech.calls, hasLength(2));
    expect(speech.calls.last.text, isNot(contains('O que você')));
    expect(speech.calls.last.text, contains('What do you like to do'));
  });

  testWidgets('consulta somente após toque longo na palavra', (tester) async {
    final speech = FakeTextToSpeech();
    final lookup = MemoryWordLookupRepository();
    await tester.pumpWidget(readerApp(speech, wordLookupRepository: lookup));
    await tester.pumpAndSettle();
    expect(lookup.calls, isEmpty);

    const wordKey = ValueKey('segment-english-line-001-s1-0');
    await tester.longPress(find.byKey(wordKey));
    await tester.pumpAndSettle();

    expect(lookup.calls, ['what']);
    expect(find.text('o que'), findsOneWidget);
    expect(find.text('Tradução automática • MyMemory'), findsOneWidget);
    expect(find.text('Ouvir palavra'), findsOneWidget);
    expect(find.text('Salvar palavra'), findsOneWidget);
  });

  testWidgets('salva a tradução automática e sua origem', (tester) async {
    final repository = MemoryVocabularyRepository();
    await tester.pumpWidget(
      readerApp(FakeTextToSpeech(), vocabularyRepository: repository),
    );
    await tester.pumpAndSettle();

    const wordKey = ValueKey('segment-english-line-001-s1-0');
    await tester.longPress(find.byKey(wordKey));
    await tester.pumpAndSettle();
    final saveButton = find.widgetWithText(FilledButton, 'Salvar palavra');
    await tester.ensureVisible(saveButton);
    await tester.tap(saveButton);
    await tester.pumpAndSettle();

    expect(repository.entries, hasLength(1));
    expect(repository.entries.single.normalizedWord, 'what');
    expect(repository.entries.single.meaning, 'o que');
    expect(repository.entries.single.meaningSource, 'mymemory');
    expect(repository.entries.single.sourceTextIds, ['text-1']);
  });

  testWidgets('envia somente a palavra normalizada ao TTS en-US', (
    tester,
  ) async {
    final speech = FakeTextToSpeech();
    await tester.pumpWidget(readerApp(speech));
    await tester.pumpAndSettle();

    const wordKey = ValueKey('segment-english-line-001-s1-0');
    await tester.longPress(find.byKey(wordKey));
    await tester.pumpAndSettle();
    final speakButton = find.widgetWithText(OutlinedButton, 'Ouvir palavra');
    await tester.ensureVisible(speakButton);
    await tester.tap(speakButton);
    await tester.pumpAndSettle();

    expect(speech.calls.single.text, 'what');
    expect(speech.calls.single.voice?.locale, 'en-US');
  });

  testWidgets('indica no leitor o estado de palavra já salva', (tester) async {
    final date = DateTime.utc(2026, 10, 14);
    final repository = MemoryVocabularyRepository([
      VocabularyEntry(
        id: 'word-1',
        word: 'What',
        normalizedWord: 'what',
        meaning: 'O que',
        status: VocabularyStatus.known,
        savedAt: date,
        updatedAt: date,
        sourceTextIds: const ['text-1'],
      ),
    ]);
    await tester.pumpWidget(
      readerApp(FakeTextToSpeech(), vocabularyRepository: repository),
    );
    await tester.pumpAndSettle();

    const wordKey = ValueKey('segment-english-line-001-s1-0');
    final word = tester.widget<Text>(find.byKey(wordKey));
    expect(word.semanticsLabel, 'What, Conhecida');
    expect(word.style?.fontWeight, FontWeight.w700);
  });
}

Widget readerApp(
  FakeTextToSpeech speech, {
  MemoryVocabularyRepository? vocabularyRepository,
  MemoryWordLookupRepository? wordLookupRepository,
}) {
  final dialogue = const DialogueParser().parse(
    jsonEncode(validDialogueJson()),
  );
  return MaterialApp(
    home: DialogueReaderPage(
      text: ImportedText(
        id: 'text-1',
        notebookId: 'notebook-1',
        dialogue: dialogue,
        sourceJson: jsonEncode(validDialogueJson()),
        importedAt: DateTime.utc(2026, 10, 14),
      ),
      textToSpeech: speech,
      vocabularyRepository:
          vocabularyRepository ?? MemoryVocabularyRepository(),
      wordLookupRepository:
          wordLookupRepository ?? MemoryWordLookupRepository(),
    ),
  );
}
