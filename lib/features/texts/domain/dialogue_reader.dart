import 'dialogue.dart';

enum DialogueLanguage { english, portuguese }

class ResolvedDialogueToken {
  const ResolvedDialogueToken({required this.text, this.segmentId});

  final String text;
  final String? segmentId;

  bool get isSegment => segmentId != null;
}

List<ResolvedDialogueToken> resolveLineTokens(
  DialogueLine line,
  DialogueLanguage language,
) {
  final segments = {for (final segment in line.segments) segment.id: segment};
  final tokens = language == DialogueLanguage.english
      ? line.englishTokens
      : line.portugueseTokens;

  return tokens
      .map((token) {
        if (!token.isSegment) {
          return ResolvedDialogueToken(text: token.text!);
        }

        final segment = segments[token.segmentId];
        if (segment == null) {
          throw StateError('Segmento inexistente: ${token.segmentId}');
        }
        return ResolvedDialogueToken(
          text: language == DialogueLanguage.english
              ? segment.english
              : segment.portuguese,
          segmentId: segment.id,
        );
      })
      .toList(growable: false);
}

String buildLineText(DialogueLine line, DialogueLanguage language) {
  return resolveLineTokens(line, language).map((token) => token.text).join();
}

String buildEnglishSpeech(DialogueDocument dialogue) {
  return dialogue.lines
      .map((line) => buildLineText(line, DialogueLanguage.english))
      .join('\n');
}

DialogueSegment findAlignedSegment(DialogueLine line, String segmentId) {
  return line.segments.firstWhere(
    (segment) => segment.id == segmentId,
    orElse: () => throw StateError('Segmento inexistente: $segmentId'),
  );
}
