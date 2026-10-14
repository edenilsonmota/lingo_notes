enum NotebookSortMode {
  manual('Manual'),
  titleAsc('Título (A–Z)'),
  createdAtDesc('Mais recentes'),
  updatedAtDesc('Atualizados recentemente');

  const NotebookSortMode(this.label);

  final String label;

  static NotebookSortMode fromStorage(String value) {
    return NotebookSortMode.values.firstWhere(
      (mode) => mode.name == value,
      orElse: () => NotebookSortMode.manual,
    );
  }
}

class Notebook {
  const Notebook({
    required this.id,
    required this.name,
    required this.description,
    required this.colorValue,
    required this.createdAt,
    required this.updatedAt,
    required this.sortMode,
    required this.position,
  });

  final String id;
  final String name;
  final String description;
  final int colorValue;
  final DateTime createdAt;
  final DateTime updatedAt;
  final NotebookSortMode sortMode;
  final int position;

  Notebook copyWith({
    String? name,
    String? description,
    int? colorValue,
    DateTime? updatedAt,
    NotebookSortMode? sortMode,
    int? position,
  }) {
    return Notebook(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      colorValue: colorValue ?? this.colorValue,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      sortMode: sortMode ?? this.sortMode,
      position: position ?? this.position,
    );
  }
}

List<Notebook> sortNotebooks(
  Iterable<Notebook> notebooks,
  NotebookSortMode mode,
) {
  final sorted = notebooks.toList();

  switch (mode) {
    case NotebookSortMode.manual:
      sorted.sort((a, b) => a.position.compareTo(b.position));
    case NotebookSortMode.titleAsc:
      sorted.sort(
        (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
      );
    case NotebookSortMode.createdAtDesc:
      sorted.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    case NotebookSortMode.updatedAtDesc:
      sorted.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  }

  return sorted;
}
