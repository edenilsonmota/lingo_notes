Uri buildMyMemoryUri(String normalizedWord) {
  return Uri.https('api.mymemory.translated.net', '/get', {
    'q': normalizedWord,
    'langpair': 'en|pt-BR',
  });
}
