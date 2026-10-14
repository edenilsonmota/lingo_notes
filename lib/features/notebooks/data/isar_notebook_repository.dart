import 'package:isar_community/isar.dart';
import 'package:uuid/uuid.dart';

import '../../texts/data/imported_text_record.dart';
import '../domain/notebook.dart';
import '../domain/notebook_repository.dart';
import 'notebook_record.dart';

class IsarNotebookRepository implements NotebookRepository {
  IsarNotebookRepository(this._isar);

  final Isar _isar;
  static const _uuid = Uuid();

  @override
  Stream<List<Notebook>> watchAll() {
    return _isar.notebookRecords.watchLazy(fireImmediately: true).asyncMap((_) {
      return _readAll();
    });
  }

  Future<List<Notebook>> _readAll() async {
    final records = await _isar.notebookRecords.where().findAll();
    final notebooks = records.map((record) => record.toDomain()).toList();
    final mode = notebooks.isEmpty
        ? NotebookSortMode.manual
        : notebooks.first.sortMode;
    return sortNotebooks(notebooks, mode);
  }

  @override
  Future<Notebook> create({
    required String name,
    required String description,
    required int colorValue,
  }) async {
    final current = await _readAll();
    final now = DateTime.now().toUtc();
    final sortMode = current.isEmpty
        ? NotebookSortMode.manual
        : current.first.sortMode;
    final notebook = Notebook(
      id: _uuid.v4(),
      name: name.trim(),
      description: description.trim(),
      colorValue: colorValue,
      createdAt: now,
      updatedAt: now,
      sortMode: sortMode,
      position: current.length,
    );

    await _isar.writeTxn(() async {
      await _isar.notebookRecords.put(NotebookRecord.fromDomain(notebook));
    });
    return notebook;
  }

  @override
  Future<void> update(Notebook notebook) async {
    final record = await _isar.notebookRecords
        .filter()
        .uuidEqualTo(notebook.id)
        .findFirst();
    if (record == null) return;

    final updated = notebook.copyWith(updatedAt: DateTime.now().toUtc());
    await _isar.writeTxn(() async {
      await _isar.notebookRecords.put(
        NotebookRecord.fromDomain(updated, databaseId: record.id),
      );
    });
  }

  @override
  Future<void> delete(String id) async {
    final record = await _isar.notebookRecords
        .filter()
        .uuidEqualTo(id)
        .findFirst();
    if (record == null) return;

    await _isar.writeTxn(() async {
      await _isar.importedTextRecords
          .filter()
          .notebookIdEqualTo(id)
          .deleteAll();
      await _isar.notebookRecords.delete(record.id);
    });
  }

  @override
  Future<void> reorder(List<Notebook> notebooks) async {
    final records = await _isar.notebookRecords.where().findAll();
    final recordsByUuid = {for (final record in records) record.uuid: record};

    await _isar.writeTxn(() async {
      for (var index = 0; index < notebooks.length; index++) {
        final record = recordsByUuid[notebooks[index].id];
        if (record == null) continue;
        record
          ..position = index
          ..sortMode = NotebookSortMode.manual.name;
        await _isar.notebookRecords.put(record);
      }
    });
  }

  @override
  Future<void> setSortMode(NotebookSortMode mode) async {
    final records = await _isar.notebookRecords.where().findAll();
    await _isar.writeTxn(() async {
      for (final record in records) {
        record.sortMode = mode.name;
        await _isar.notebookRecords.put(record);
      }
    });
  }
}
