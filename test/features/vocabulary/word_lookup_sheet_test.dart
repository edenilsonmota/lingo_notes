import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lingo_notes/features/vocabulary/domain/word_lookup.dart';
import 'package:lingo_notes/features/vocabulary/domain/word_lookup_repository.dart';
import 'package:lingo_notes/features/vocabulary/presentation/word_lookup_sheet.dart';

import '../../support/memory_vocabulary_repository.dart';
import '../../support/memory_word_lookup_repository.dart';

void main() {
  testWidgets('mostra carregamento e tradução', (tester) async {
    final repository = _PendingLookupRepository();
    await tester.pumpWidget(sheetApp(repository));

    expect(find.text('Consultando tradução...'), findsOneWidget);

    repository.completer.complete(sampleWordLookupResult());
    await tester.pumpAndSettle();

    expect(find.text('o que'), findsOneWidget);
    expect(find.text('Ouvir palavra'), findsOneWidget);
  });

  testWidgets('mostra erro de rede e permite tentar novamente', (tester) async {
    final repository = _FailsOnceLookupRepository();
    await tester.pumpWidget(sheetApp(repository));
    await tester.pumpAndSettle();

    expect(find.text('Não foi possível consultar agora.'), findsOneWidget);
    expect(find.text('Tentar novamente'), findsOneWidget);

    await tester.tap(find.text('Tentar novamente'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('o que'), findsOneWidget);
    expect(repository.calls, 2);
  });
}

Widget sheetApp(WordLookupRepository repository) {
  return MaterialApp(
    home: Scaffold(
      body: WordLookupSheet(
        word: 'what',
        sourceTextId: 'text-1',
        lookupRepository: repository,
        vocabularyRepository: MemoryVocabularyRepository(),
        onSpeak: (_) async {},
      ),
    ),
  );
}

class _PendingLookupRepository implements WordLookupRepository {
  final completer = Completer<WordLookupResult>();

  @override
  Future<WordLookupResult> lookup(String word) => completer.future;
}

class _FailsOnceLookupRepository implements WordLookupRepository {
  int calls = 0;

  @override
  Future<WordLookupResult> lookup(String word) async {
    calls++;
    if (calls == 1) {
      throw const WordLookupException(WordLookupFailure.network, 'offline');
    }
    return sampleWordLookupResult();
  }
}
