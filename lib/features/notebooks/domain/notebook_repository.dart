import 'notebook.dart';

abstract interface class NotebookRepository {
  Stream<List<Notebook>> watchAll();

  Future<Notebook> create({
    required String name,
    required String description,
    required int colorValue,
  });

  Future<void> update(Notebook notebook);

  Future<void> delete(String id);

  Future<void> reorder(List<Notebook> notebooks);

  Future<void> setSortMode(NotebookSortMode mode);
}
