import 'package:flutter/material.dart';

import '../domain/vocabulary_entry.dart';
import '../domain/vocabulary_repository.dart';
import '../domain/word_lookup.dart';
import '../domain/word_lookup_repository.dart';

class WordLookupSheet extends StatefulWidget {
  const WordLookupSheet({
    required this.word,
    required this.sourceTextId,
    required this.lookupRepository,
    required this.vocabularyRepository,
    required this.onSpeak,
    this.existingEntry,
    super.key,
  });

  final String word;
  final String sourceTextId;
  final WordLookupRepository lookupRepository;
  final VocabularyRepository vocabularyRepository;
  final Future<void> Function(String word) onSpeak;
  final VocabularyEntry? existingEntry;

  @override
  State<WordLookupSheet> createState() => _WordLookupSheetState();
}

class _WordLookupSheetState extends State<WordLookupSheet> {
  late Future<WordLookupResult> _lookup;
  bool _saving = false;
  bool _speaking = false;
  late bool _saved;

  @override
  void initState() {
    super.initState();
    _saved = widget.existingEntry != null;
    _lookup = widget.lookupRepository.lookup(widget.word);
  }

  void _retry() {
    setState(() {
      _lookup = widget.lookupRepository.lookup(widget.word);
    });
  }

  Future<void> _speak(WordLookupResult result) async {
    if (_speaking) return;
    setState(() => _speaking = true);
    try {
      await widget.onSpeak(result.normalizedWord);
    } on Object {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Não foi possível falar a palavra.')),
        );
      }
    } finally {
      if (mounted) setState(() => _speaking = false);
    }
  }

  Future<void> _save(WordLookupResult result) async {
    if (_saving) return;
    setState(() => _saving = true);
    try {
      await widget.vocabularyRepository.saveWord(
        word: result.word,
        meaning: result.translation,
        meaningSource: result.translationSource,
        sourceTextId: widget.sourceTextId,
      );
      if (!mounted) return;
      setState(() => _saved = true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Palavra salva no vocabulário.')),
      );
    } on Object {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Não foi possível salvar a palavra.')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 4, 24, 32),
        child: FutureBuilder<WordLookupResult>(
          future: _lookup,
          builder: (context, snapshot) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.word,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                if (snapshot.connectionState != ConnectionState.done)
                  const _LoadingState()
                else if (snapshot.hasError)
                  _LookupError(error: snapshot.error, onRetry: _retry)
                else
                  _LookupDetails(
                    result: snapshot.requireData,
                    saved: _saved,
                    saving: _saving,
                    speaking: _speaking,
                    onSpeak: () => _speak(snapshot.requireData),
                    onSave: () => _save(snapshot.requireData),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 36),
      child: Center(
        child: Column(
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Consultando tradução...'),
          ],
        ),
      ),
    );
  }
}

class _LookupError extends StatelessWidget {
  const _LookupError({required this.error, required this.onRetry});

  final Object? error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final failure = error is WordLookupException
        ? (error! as WordLookupException).failure
        : WordLookupFailure.network;
    final notFound = failure == WordLookupFailure.notFound;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: Column(
          children: [
            Icon(
              notFound ? Icons.search_off : Icons.wifi_off_outlined,
              size: 48,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 12),
            Text(
              notFound
                  ? 'Nenhum resultado encontrado.'
                  : 'Não foi possível consultar agora.',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              notFound
                  ? 'Confira a palavra e tente novamente.'
                  : 'Verifique sua conexão e tente novamente.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Tentar novamente'),
            ),
          ],
        ),
      ),
    );
  }
}

class _LookupDetails extends StatelessWidget {
  const _LookupDetails({
    required this.result,
    required this.saved,
    required this.saving,
    required this.speaking,
    required this.onSpeak,
    required this.onSave,
  });

  final WordLookupResult result;
  final bool saved;
  final bool saving;
  final bool speaking;
  final VoidCallback onSpeak;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tradução', style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 4),
        Text(result.translation, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 4),
        const Text('Tradução automática • MyMemory'),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: speaking ? null : onSpeak,
                icon: const Icon(Icons.volume_up_outlined),
                label: Text(speaking ? 'Reproduzindo...' : 'Ouvir palavra'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton.icon(
                onPressed: saving ? null : onSave,
                icon: Icon(
                  saved ? Icons.bookmark : Icons.bookmark_add_outlined,
                ),
                label: Text(
                  saving
                      ? 'Salvando...'
                      : saved
                      ? 'Atualizar palavra'
                      : 'Salvar palavra',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
