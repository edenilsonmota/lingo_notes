import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lingo_notes/features/notebooks/domain/notebook.dart';
import 'package:lingo_notes/features/texts/domain/dialogue.dart';
import 'package:lingo_notes/features/texts/domain/dialogue_file_picker.dart';
import 'package:lingo_notes/features/texts/domain/text_repository.dart';
import 'package:lingo_notes/features/texts/presentation/notebook_texts_page.dart';

import 'dialogue_parser_test.dart' show validDialogueJson;
import '../../support/fake_text_to_speech.dart';
import '../../support/memory_vocabulary_repository.dart';

void main() {
  testWidgets('importa e lista um arquivo válido', (tester) async {
    final repository = MemoryTextRepository();
    final picker = MemoryFilePicker(jsonEncode(validDialogueJson()));

    await tester.pumpWidget(testApp(repository, picker));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Importar JSON'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Free-time conversation'), findsOneWidget);
    expect(find.text('Diálogo • 1 linha • A2'), findsOneWidget);
    expect(repository.saved, hasLength(1));
  });

  testWidgets('mostra erros e não salva um arquivo inválido', (tester) async {
    final repository = MemoryTextRepository();
    final picker = MemoryFilePicker('{"format":"invalid"}');

    await tester.pumpWidget(testApp(repository, picker));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Importar JSON'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Arquivo inválido'), findsOneWidget);
    expect(find.textContaining(r'$.version'), findsOneWidget);
    expect(repository.saved, isEmpty);
  });
}

Widget testApp(TextRepository repository, DialogueFilePicker picker) {
  return MaterialApp(
    home: NotebookTextsPage(
      notebook: Notebook(
        id: 'notebook-1',
        name: 'Conversações',
        description: '',
        colorValue: 0xFF315C49,
        createdAt: DateTime.utc(2026, 10, 14),
        updatedAt: DateTime.utc(2026, 10, 14),
        sortMode: NotebookSortMode.manual,
        position: 0,
      ),
      textRepository: repository,
      filePicker: picker,
      textToSpeech: FakeTextToSpeech(),
      vocabularyRepository: MemoryVocabularyRepository(),
    ),
  );
}

class MemoryFilePicker implements DialogueFilePicker {
  MemoryFilePicker(String source)
    : _file = PickedDialogueFile(
        name: 'dialogue.json',
        bytes: Uint8List.fromList(utf8.encode(source)),
      );

  final PickedDialogueFile _file;

  @override
  Future<PickedDialogueFile?> pickJson() async => _file;
}

class MemoryTextRepository implements TextRepository {
  final saved = <ImportedText>[];
  final _changes = StreamController<List<ImportedText>>.broadcast();

  @override
  Future<void> save({
    required String notebookId,
    required DialogueDocument dialogue,
    required String sourceJson,
  }) async {
    saved.add(
      ImportedText(
        id: 'generated-${saved.length + 1}',
        notebookId: notebookId,
        dialogue: dialogue,
        sourceJson: sourceJson,
        importedAt: DateTime.utc(2026, 10, 14),
      ),
    );
    _changes.add(List.unmodifiable(saved));
  }

  @override
  Stream<List<ImportedText>> watchByNotebook(String notebookId) async* {
    yield List.unmodifiable(saved);
    yield* _changes.stream;
  }
}
