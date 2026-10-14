import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../features/ai_generation/data/ai_generation_record.dart';
import '../features/notebooks/data/notebook_record.dart';
import '../features/texts/data/imported_text_record.dart';
import '../features/vocabulary/data/vocabulary_entry_record.dart';
import '../features/vocabulary/data/word_lookup_record.dart';

class AppDatabase {
  const AppDatabase(this.isar);

  final Isar isar;

  static Future<AppDatabase> open() async {
    final directory = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [
        AiGenerationRecordSchema,
        NotebookRecordSchema,
        ImportedTextRecordSchema,
        VocabularyEntryRecordSchema,
        WordLookupRecordSchema,
      ],
      directory: directory.path,
      name: 'lingo_notes',
    );
    return AppDatabase(isar);
  }
}
