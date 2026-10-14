import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:lingo_notes/features/vocabulary/data/public_word_lookup_remote_source.dart';

void main() {
  test('consulta somente a tradução pública da palavra na MyMemory', () async {
    final requestedUrls = <Uri>[];
    final client = MockClient((request) async {
      requestedUrls.add(request.url);
      return http.Response(
        '{"responseData":{"translatedText":"olá"},"responseStatus":200}',
        200,
        headers: {'content-type': 'application/json; charset=utf-8'},
      );
    });
    final source = PublicWordLookupRemoteSource(
      client,
      now: () => DateTime.utc(2026, 10, 14),
    );

    final result = await source.fetch('hello');

    expect(requestedUrls, hasLength(1));
    expect(requestedUrls.single.host, 'api.mymemory.translated.net');
    expect(requestedUrls.single.queryParameters['q'], 'hello');
    expect(requestedUrls.single.queryParameters['langpair'], 'en|pt-BR');
    expect(result.word, 'hello');
    expect(result.translation, 'olá');
    expect(result.translationSource, 'mymemory');
  });
}
