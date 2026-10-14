import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lingo_notes/app/lingo_notes_app.dart';
import 'package:lingo_notes/features/notebooks/domain/notebook.dart';
import 'package:lingo_notes/features/notebooks/domain/notebook_repository.dart';
import 'package:lingo_notes/features/texts/domain/dialogue.dart';
import 'package:lingo_notes/features/texts/domain/dialogue_file_picker.dart';
import 'package:lingo_notes/features/texts/domain/text_repository.dart';
import 'package:lingo_notes/features/ai_generation/data/simulated_ai_generation_gateway.dart';

import '../../support/fake_text_to_speech.dart';
import '../../support/memory_ai_generation.dart';
import '../../support/memory_vocabulary_repository.dart';
import '../../support/memory_word_lookup_repository.dart';

void main() {
  testWidgets('cria um caderno pela tela inicial', (tester) async {
    final repository = FakeNotebookRepository();
    await tester.pumpWidget(_buildApp(repository));
    await tester.pumpAndSettle();

    expect(find.text('Crie seu primeiro caderno'), findsOneWidget);

    await tester.tap(find.text('Novo caderno'));
    await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextFormField, 'Nome'), 'Jogos');
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Descrição (opcional)'),
      'Vocabulário de RPG',
    );
    await tester.tap(find.text('Criar'));
    await tester.pumpAndSettle();

    expect(find.text('Jogos'), findsOneWidget);
    expect(find.text('Vocabulário de RPG'), findsOneWidget);
  });

  testWidgets('impede criar caderno sem nome', (tester) async {
    final repository = FakeNotebookRepository();
    await tester.pumpWidget(_buildApp(repository));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Novo caderno'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Criar'));
    await tester.pump();

    expect(find.text('Informe o nome do caderno.'), findsOneWidget);
    expect(repository.items, isEmpty);
  });
}

Widget _buildApp(NotebookRepository repository) {
  return LingoNotesApp(
    notebookRepository: repository,
    textRepository: _EmptyTextRepository(),
    filePicker: const _CancelledFilePicker(),
    textToSpeech: FakeTextToSpeech(),
    vocabularyRepository: MemoryVocabularyRepository(),
    wordLookupRepository: MemoryWordLookupRepository(),
    aiGenerationGateway: SimulatedAiGenerationGateway(),
    aiSourceFilePicker: const CancelledAiSourceFilePicker(),
    aiGenerationMetadataRepository: MemoryAiGenerationMetadataRepository(),
  );
}

class _EmptyTextRepository implements TextRepository {
  @override
  Future<void> save({
    required String notebookId,
    required DialogueDocument dialogue,
    required String sourceJson,
  }) async {}

  @override
  Stream<List<ImportedText>> watchByNotebook(String notebookId) {
    return Stream.value(const []);
  }
}

class _CancelledFilePicker implements DialogueFilePicker {
  const _CancelledFilePicker();

  @override
  Future<PickedDialogueFile?> pickJson() async => null;
}

class FakeNotebookRepository implements NotebookRepository {
  final _changes = StreamController<List<Notebook>>.broadcast();
  final items = <Notebook>[];

  @override
  Stream<List<Notebook>> watchAll() async* {
    yield List.unmodifiable(items);
    yield* _changes.stream;
  }

  void _emit() => _changes.add(List.unmodifiable(items));

  @override
  Future<Notebook> create({
    required String name,
    required String description,
    required int colorValue,
  }) async {
    final now = DateTime.utc(2026, 10, 14);
    final notebook = Notebook(
      id: 'notebook-${items.length + 1}',
      name: name,
      description: description,
      colorValue: colorValue,
      createdAt: now,
      updatedAt: now,
      sortMode: NotebookSortMode.manual,
      position: items.length,
    );
    items.add(notebook);
    _emit();
    return notebook;
  }

  @override
  Future<void> delete(String id) async {
    items.removeWhere((item) => item.id == id);
    _emit();
  }

  @override
  Future<void> reorder(List<Notebook> notebooks) async {
    items
      ..clear()
      ..addAll(notebooks);
    _emit();
  }

  @override
  Future<void> setSortMode(NotebookSortMode mode) async {
    final updated = [for (final item in items) item.copyWith(sortMode: mode)];
    items
      ..clear()
      ..addAll(sortNotebooks(updated, mode));
    _emit();
  }

  @override
  Future<void> update(Notebook notebook) async {
    final index = items.indexWhere((item) => item.id == notebook.id);
    if (index >= 0) items[index] = notebook;
    _emit();
  }
}
