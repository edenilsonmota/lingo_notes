import 'package:flutter/material.dart';

import '../features/notebooks/domain/notebook_repository.dart';
import '../features/notebooks/presentation/notebooks_page.dart';

class LingoNotesApp extends StatelessWidget {
  const LingoNotesApp({required this.repository, super.key});

  final NotebookRepository repository;

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
      home: NotebooksPage(repository: repository),
    );
  }
}
