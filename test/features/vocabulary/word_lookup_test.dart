import 'package:flutter_test/flutter_test.dart';
import 'package:lingo_notes/features/vocabulary/data/cached_word_lookup_repository.dart';
import 'package:lingo_notes/features/vocabulary/data/word_lookup_endpoints.dart';
import 'package:lingo_notes/features/vocabulary/domain/word_lookup.dart';
import 'package:lingo_notes/features/vocabulary/domain/word_lookup_repository.dart';

void main() {
  test('monta a requisição MyMemory somente para en e pt-BR', () {
    final uri = buildMyMemoryUri("don't");

    expect(uri.scheme, 'https');
    expect(uri.host, 'api.mymemory.translated.net');
    expect(uri.path, '/get');
    expect(uri.queryParameters['q'], "don't");
    expect(uri.queryParameters['langpair'], 'en|pt-BR');
    expect(uri.queryParameters, hasLength(2));
  });

  test('normaliza antes da consulta e reutiliza o cache local', () async {
    final cache = _MemoryLookupCache();
    final remote = _RecordingRemote();
    final repository = CachedWordLookupRepository(cache: cache, remote: remote);

    final first = await repository.lookup('  “HELLO!”  ');
    final second = await repository.lookup('hello');

    expect(first.normalizedWord, 'hello');
    expect(identical(first, second), isTrue);
    expect(remote.calls, ['hello']);
    expect(cache.saved, ['hello']);
  });

  test('rejeita frases sem consultar os serviços externos', () async {
    final remote = _RecordingRemote();
    final repository = CachedWordLookupRepository(
      cache: _MemoryLookupCache(),
      remote: remote,
    );

    await expectLater(
      repository.lookup('translate this whole sentence'),
      throwsA(isA<WordLookupException>()),
    );

    expect(remote.calls, isEmpty);
  });
}

class _MemoryLookupCache implements WordLookupCache {
  final values = <String, WordLookupResult>{};
  final saved = <String>[];

  @override
  Future<WordLookupResult?> find(String normalizedWord) async {
    return values[normalizedWord];
  }

  @override
  Future<void> save(WordLookupResult result) async {
    saved.add(result.normalizedWord);
    values[result.normalizedWord] = result;
  }
}

class _RecordingRemote implements WordLookupRemoteSource {
  final calls = <String>[];

  @override
  Future<WordLookupResult> fetch(String normalizedWord) async {
    calls.add(normalizedWord);
    return WordLookupResult(
      word: normalizedWord,
      normalizedWord: normalizedWord,
      translation: 'olá',
      translationSource: 'mymemory',
      fetchedAt: DateTime.utc(2026, 10, 14),
    );
  }
}
