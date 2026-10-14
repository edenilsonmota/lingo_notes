import 'package:flutter/material.dart';

import 'app/app_database.dart';
import 'app/lingo_notes_app.dart';
import 'features/notebooks/data/isar_notebook_repository.dart';
import 'features/texts/data/device_dialogue_file_picker.dart';
import 'features/texts/data/isar_text_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await AppDatabase.open();
  runApp(
    LingoNotesApp(
      notebookRepository: IsarNotebookRepository(database.isar),
      textRepository: IsarTextRepository(database.isar),
      filePicker: const DeviceDialogueFilePicker(),
    ),
  );
}
