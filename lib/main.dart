import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'app/app_database.dart';
import 'app/lingo_notes_app.dart';
import 'features/ai_generation/data/device_ai_source_file_picker.dart';
import 'features/ai_generation/data/isar_ai_generation_metadata_repository.dart';
import 'features/ai_generation/data/simulated_ai_generation_gateway.dart';
import 'features/notebooks/data/isar_notebook_repository.dart';
import 'features/texts/data/device_dialogue_file_picker.dart';
import 'features/texts/data/flutter_text_to_speech.dart';
import 'features/texts/data/isar_text_repository.dart';
import 'features/vocabulary/data/isar_vocabulary_repository.dart';
import 'features/vocabulary/data/cached_word_lookup_repository.dart';
import 'features/vocabulary/data/isar_word_lookup_cache.dart';
import 'features/vocabulary/data/public_word_lookup_remote_source.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await AppDatabase.open();
  final httpClient = http.Client();
  runApp(
    LingoNotesApp(
      notebookRepository: IsarNotebookRepository(database.isar),
      textRepository: IsarTextRepository(database.isar),
      filePicker: const DeviceDialogueFilePicker(),
      textToSpeech: FlutterTextToSpeech(),
      vocabularyRepository: IsarVocabularyRepository(database.isar),
      wordLookupRepository: CachedWordLookupRepository(
        cache: IsarWordLookupCache(database.isar),
        remote: PublicWordLookupRemoteSource(httpClient),
      ),
      aiGenerationGateway: SimulatedAiGenerationGateway(),
      aiSourceFilePicker: const DeviceAiSourceFilePicker(),
      aiGenerationMetadataRepository: IsarAiGenerationMetadataRepository(
        database.isar,
      ),
    ),
  );
}
