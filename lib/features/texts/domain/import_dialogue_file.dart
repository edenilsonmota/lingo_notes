import 'dart:convert';

import 'dialogue.dart';
import 'dialogue_file_picker.dart';
import 'dialogue_parser.dart';
import 'text_repository.dart';

class ImportDialogueFile {
  const ImportDialogueFile(
    this._repository, [
    this._parser = const DialogueParser(),
  ]);

  final TextRepository _repository;
  final DialogueParser _parser;

  Future<DialogueDocument> call({
    required String notebookId,
    required PickedDialogueFile file,
  }) async {
    final String source;
    try {
      source = utf8.decode(file.bytes, allowMalformed: false);
    } on FormatException {
      throw const DialogueValidationException([
        DialogueValidationIssue(
          r'$',
          'O arquivo precisa estar codificado em UTF-8.',
        ),
      ]);
    }

    final dialogue = _parser.parse(source);
    await _repository.save(
      notebookId: notebookId,
      dialogue: dialogue,
      sourceJson: source,
    );
    return dialogue;
  }
}
