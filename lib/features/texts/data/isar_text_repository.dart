import 'package:isar_community/isar.dart';
import 'package:uuid/uuid.dart';

import '../domain/dialogue.dart';
import '../domain/dialogue_parser.dart';
import '../domain/text_repository.dart';
import 'imported_text_record.dart';

class IsarTextRepository implements TextRepository {
  IsarTextRepository(this._isar, [this._parser = const DialogueParser()]);

  final Isar _isar;
  final DialogueParser _parser;
  static const _uuid = Uuid();

  @override
  Stream<List<ImportedText>> watchByNotebook(String notebookId) {
    return _isar.importedTextRecords
        .filter()
        .notebookIdEqualTo(notebookId)
        .watch(fireImmediately: true)
        .map((records) {
          final texts = records.map(_toDomain).toList();
          texts.sort((a, b) => b.importedAt.compareTo(a.importedAt));
          return texts;
        });
  }

  @override
  Future<void> save({
    required String notebookId,
    required DialogueDocument dialogue,
    required String sourceJson,
  }) async {
    final record = ImportedTextRecord()
      ..uuid = _uuid.v4()
      ..notebookId = notebookId
      ..sourceId = dialogue.sourceId
      ..title = dialogue.title
      ..contentType = dialogue.contentType.name
      ..sourceLanguage = dialogue.sourceLanguage
      ..targetLanguage = dialogue.targetLanguage
      ..level = dialogue.level
      ..tags = List.of(dialogue.tags)
      ..sourceJson = sourceJson
      ..importedAt = DateTime.now().toUtc();

    await _isar.writeTxn(() async {
      await _isar.importedTextRecords.put(record);
    });
  }

  ImportedText _toDomain(ImportedTextRecord record) {
    return ImportedText(
      id: record.uuid,
      notebookId: record.notebookId,
      dialogue: _parser.parse(record.sourceJson),
      sourceJson: record.sourceJson,
      importedAt: record.importedAt,
    );
  }
}
