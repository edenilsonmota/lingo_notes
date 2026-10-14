import 'package:flutter_test/flutter_test.dart';
import 'package:lingo_notes/features/notebooks/domain/notebook.dart';

void main() {
  final baseDate = DateTime.utc(2026, 10, 13);

  Notebook notebook({
    required String id,
    required String name,
    required int position,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Notebook(
      id: id,
      name: name,
      description: '',
      colorValue: 0xFF315C49,
      createdAt: createdAt ?? baseDate,
      updatedAt: updatedAt ?? baseDate,
      sortMode: NotebookSortMode.manual,
      position: position,
    );
  }

  test('ordena cadernos pela posição manual', () {
    final result = sortNotebooks([
      notebook(id: '2', name: 'Segundo', position: 1),
      notebook(id: '1', name: 'Primeiro', position: 0),
    ], NotebookSortMode.manual);

    expect(result.map((item) => item.id), ['1', '2']);
  });

  test('ordena títulos sem diferenciar maiúsculas e minúsculas', () {
    final result = sortNotebooks([
      notebook(id: '2', name: 'jogos', position: 0),
      notebook(id: '1', name: 'Conversações', position: 1),
    ], NotebookSortMode.titleAsc);

    expect(result.map((item) => item.id), ['1', '2']);
  });

  test('ordena pela atualização mais recente', () {
    final result = sortNotebooks([
      notebook(id: '1', name: 'Antigo', position: 0),
      notebook(
        id: '2',
        name: 'Novo',
        position: 1,
        updatedAt: baseDate.add(const Duration(days: 1)),
      ),
    ], NotebookSortMode.updatedAtDesc);

    expect(result.first.id, '2');
  });
}
