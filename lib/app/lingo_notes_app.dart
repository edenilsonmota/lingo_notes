import 'package:flutter/material.dart';

import '../features/ai_generation/domain/ai_generation_gateway.dart';
import '../features/ai_generation/domain/ai_source_file_picker.dart';
import '../features/notebooks/domain/notebook_repository.dart';
import '../features/notebooks/presentation/notebooks_page.dart';
import '../features/texts/domain/dialogue_file_picker.dart';
import '../features/texts/domain/text_repository.dart';
import '../features/texts/domain/text_to_speech.dart';
import '../features/vocabulary/domain/vocabulary_repository.dart';
import '../features/vocabulary/domain/word_lookup_repository.dart';

class LingoNotesApp extends StatelessWidget {
  const LingoNotesApp({
    required this.notebookRepository,
    required this.textRepository,
    required this.filePicker,
    required this.textToSpeech,
    required this.vocabularyRepository,
    required this.wordLookupRepository,
    required this.aiGenerationGateway,
    required this.aiSourceFilePicker,
    required this.aiGenerationMetadataRepository,
    super.key,
  });

  final NotebookRepository notebookRepository;
  final TextRepository textRepository;
  final DialogueFilePicker filePicker;
  final TextToSpeech textToSpeech;
  final VocabularyRepository vocabularyRepository;
  final WordLookupRepository wordLookupRepository;
  final AiGenerationGateway aiGenerationGateway;
  final AiSourceFilePicker aiSourceFilePicker;
  final AiGenerationMetadataRepository aiGenerationMetadataRepository;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF315C49),
      brightness: Brightness.light,
    );

    return MaterialApp(
      title: 'Lingo Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: const Color(0xFFF7F8F4),
        appBarTheme: const AppBarTheme(centerTitle: false),
        cardTheme: const CardThemeData(elevation: 0, margin: EdgeInsets.zero),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: NotebooksPage(
        repository: notebookRepository,
        textRepository: textRepository,
        filePicker: filePicker,
        textToSpeech: textToSpeech,
        vocabularyRepository: vocabularyRepository,
        wordLookupRepository: wordLookupRepository,
        aiGenerationGateway: aiGenerationGateway,
        aiSourceFilePicker: aiSourceFilePicker,
        aiGenerationMetadataRepository: aiGenerationMetadataRepository,
      ),
    );
  }
}
