import 'package:flutter/material.dart';

import '../domain/notebook.dart';

class NotebookDetailPage extends StatelessWidget {
  const NotebookDetailPage({required this.notebook, super.key});

  final Notebook notebook;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(notebook.name)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.article_outlined,
                size: 64,
                color: Color(notebook.colorValue),
              ),
              const SizedBox(height: 20),
              Text(
                'Nenhum texto neste caderno',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'A importação de textos será adicionada na próxima etapa.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
