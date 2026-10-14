import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lingo_notes/features/ai_generation/data/simulated_ai_generation_gateway.dart';
import 'package:lingo_notes/features/ai_generation/domain/ai_generation.dart';
import 'package:lingo_notes/features/ai_generation/presentation/ai_generation_page.dart';
import 'package:lingo_notes/features/notebooks/domain/notebook.dart';
import 'package:lingo_notes/features/notebooks/domain/notebook_repository.dart';
import 'package:lingo_notes/features/texts/domain/dialogue.dart';
import 'package:lingo_notes/features/texts/domain/text_repository.dart';

import '../../support/memory_ai_generation.dart';

void main() {
  testWidgets('só salva a geração depois da prévia e confirmação', (
    tester,
  ) async {
    final notebooks = _MemoryNotebookRepository();
    final texts = _MemoryTextRepository();
    final metadata = MemoryAiGenerationMetadataRepository();
    await tester.pumpWidget(
      MaterialApp(
        home: AiGenerationPage(
          notebookRepository: notebooks,
          textRepository: texts,
          filePicker: const CancelledAiSourceFilePicker(),
          gateway: SimulatedAiGenerationGateway(
            now: () => DateTime.utc(2026, 10, 14),
          ),
          metadataRepository: metadata,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextField, 'Título'),
      'A greeting',
    );
    await tester.enterText(
      find.byKey(const ValueKey('ai-source-text')),
      'Anna: Hello!',
    );
    await tester.drag(find.byType(ListView), const Offset(0, -700));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('ai-profile')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Econômico • OpenAI').last);
    await tester.pumpAndSettle();
    await tester.drag(find.byType(ListView), const Offset(0, -500));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('ai-generate')));
    await tester.pumpAndSettle();

    expect(find.text('Prévia'), findsOneWidget);
    expect(find.text('Anna'), findsOneWidget);
    expect(texts.saved, isEmpty);
    expect(metadata.saved.single.status, AiGenerationStatus.previewReady);

    await tester.drag(find.byType(ListView), const Offset(0, -500));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('ai-target-notebook')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Estudos').last);
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const ValueKey('ai-confirm')));
    await tester.tap(find.byKey(const ValueKey('ai-confirm')));
    await tester.pumpAndSettle();

    expect(find.text('Texto salvo'), findsOneWidget);
    expect(texts.saved, hasLength(1));
    expect(texts.saved.single.notebookId, 'notebook-1');
    expect(texts.saved.single.dialogue.title, 'A greeting');
    expect(metadata.saved.single.status, AiGenerationStatus.confirmed);
    expect(metadata.saved.single.notebookId, 'notebook-1');
  });
}

class _MemoryNotebookRepository implements NotebookRepository {
  final _controller = StreamController<List<Notebook>>.broadcast();
  final items = <Notebook>[
    Notebook(
      id: 'notebook-1',
      name: 'Estudos',
      description: '',
      colorValue: 0xFF315C49,
      createdAt: DateTime.utc(2026, 10, 14),
      updatedAt: DateTime.utc(2026, 10, 14),
      sortMode: NotebookSortMode.manual,
      position: 0,
    ),
  ];

  @override
  Stream<List<Notebook>> watchAll() async* {
    yield List.unmodifiable(items);
    yield* _controller.stream;
  }

  @override
  Future<Notebook> create({
    required String name,
    required String description,
    required int colorValue,
  }) async {
    final notebook = Notebook(
      id: 'notebook-${items.length + 1}',
      name: name.trim(),
      description: description,
      colorValue: colorValue,
      createdAt: DateTime.utc(2026, 10, 14),
      updatedAt: DateTime.utc(2026, 10, 14),
      sortMode: NotebookSortMode.manual,
      position: items.length,
    );
    items.add(notebook);
    _controller.add(List.unmodifiable(items));
    return notebook;
  }

  @override
  Future<void> delete(String id) async {}

  @override
  Future<void> reorder(List<Notebook> notebooks) async {}

  @override
  Future<void> setSortMode(NotebookSortMode mode) async {}

  @override
  Future<void> update(Notebook notebook) async {}
}

class _MemoryTextRepository implements TextRepository {
  final saved = <ImportedText>[];

  @override
  Future<void> save({
    required String notebookId,
    required DialogueDocument dialogue,
    required String sourceJson,
  }) async {
    saved.add(
      ImportedText(
        id: 'text-${saved.length + 1}',
        notebookId: notebookId,
        dialogue: dialogue,
        sourceJson: sourceJson,
        importedAt: DateTime.utc(2026, 10, 14),
      ),
    );
  }

  @override
  Stream<List<ImportedText>> watchByNotebook(String notebookId) {
    return Stream.value(
      saved.where((item) => item.notebookId == notebookId).toList(),
    );
  }
}
