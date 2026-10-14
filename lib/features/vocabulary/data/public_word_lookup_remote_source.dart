import 'dart:convert';

import 'package:http/http.dart' as http;

import '../domain/word_lookup.dart';
import '../domain/word_lookup_repository.dart';
import 'word_lookup_endpoints.dart';

class PublicWordLookupRemoteSource implements WordLookupRemoteSource {
  PublicWordLookupRemoteSource(this._client, {DateTime Function()? now})
    : _now = now ?? DateTime.now;

  final http.Client _client;
  final DateTime Function() _now;

  @override
  Future<WordLookupResult> fetch(String normalizedWord) async {
    try {
      final response = await _client
          .get(buildMyMemoryUri(normalizedWord))
          .timeout(const Duration(seconds: 12));
      final translation = _readTranslation(response);
      return WordLookupResult(
        word: normalizedWord,
        normalizedWord: normalizedWord,
        translation: translation,
        translationSource: 'mymemory',
        fetchedAt: _now().toUtc(),
      );
    } on WordLookupException {
      rethrow;
    } on Object {
      throw const WordLookupException(
        WordLookupFailure.network,
        'Não foi possível acessar o serviço de tradução.',
      );
    }
  }

  String _readTranslation(http.Response response) {
    if (response.statusCode != 200) {
      throw WordLookupException(
        response.statusCode == 404
            ? WordLookupFailure.notFound
            : WordLookupFailure.network,
        'A tradução não está disponível no momento.',
      );
    }

    final dynamic decoded;
    try {
      decoded = jsonDecode(utf8.decode(response.bodyBytes));
    } on FormatException {
      throw const WordLookupException(
        WordLookupFailure.invalidResponse,
        'A resposta da tradução é inválida.',
      );
    }
    if (decoded is! Map<String, dynamic>) {
      throw const WordLookupException(
        WordLookupFailure.invalidResponse,
        'A resposta da tradução é inválida.',
      );
    }
    final responseStatus = decoded['responseStatus'];
    if (responseStatus is num && responseStatus != 200) {
      throw const WordLookupException(
        WordLookupFailure.network,
        'O serviço de tradução recusou a consulta ou atingiu seu limite.',
      );
    }
    final responseData = decoded['responseData'];
    final translated = responseData is Map<String, dynamic>
        ? responseData['translatedText']
        : null;
    if (translated is! String || translated.trim().isEmpty) {
      throw const WordLookupException(
        WordLookupFailure.notFound,
        'Nenhuma tradução foi encontrada para esta palavra.',
      );
    }
    return translated.trim();
  }
}
