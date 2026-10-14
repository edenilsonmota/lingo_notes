import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../features/notebooks/data/notebook_record.dart';
import '../features/texts/data/imported_text_record.dart';

class AppDatabase {
  const AppDatabase(this.isar);

  final Isar isar;

  static Future<AppDatabase> open() async {
    final directory = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [NotebookRecordSchema, ImportedTextRecordSchema],
      directory: directory.path,
      name: 'lingo_notes',
    );
    return AppDatabase(isar);
  }
}
