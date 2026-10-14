import 'package:flutter/material.dart';

import 'app/lingo_notes_app.dart';
import 'features/notebooks/data/isar_notebook_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final repository = await IsarNotebookRepository.open();
  runApp(LingoNotesApp(repository: repository));
}
