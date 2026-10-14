import 'dialogue.dart';

abstract interface class TextRepository {
  Stream<List<ImportedText>> watchByNotebook(String notebookId);

  Future<void> save({
    required String notebookId,
    required DialogueDocument dialogue,
    required String sourceJson,
  });
}
