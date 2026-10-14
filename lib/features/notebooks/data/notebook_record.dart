import 'package:isar_community/isar.dart';

import '../domain/notebook.dart';

part 'notebook_record.g.dart';

@collection
class NotebookRecord {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uuid;

  late String name;
  String description = '';
  late int colorValue;
  late DateTime createdAt;
  late DateTime updatedAt;
  String sortMode = NotebookSortMode.manual.name;
  int position = 0;

  Notebook toDomain() {
    return Notebook(
      id: uuid,
      name: name,
      description: description,
      colorValue: colorValue,
      createdAt: createdAt,
      updatedAt: updatedAt,
      sortMode: NotebookSortMode.fromStorage(sortMode),
      position: position,
    );
  }

  static NotebookRecord fromDomain(Notebook notebook, {Id? databaseId}) {
    return NotebookRecord()
      ..id = databaseId ?? Isar.autoIncrement
      ..uuid = notebook.id
      ..name = notebook.name
      ..description = notebook.description
      ..colorValue = notebook.colorValue
      ..createdAt = notebook.createdAt
      ..updatedAt = notebook.updatedAt
      ..sortMode = notebook.sortMode.name
      ..position = notebook.position;
  }
}
