import 'package:flutter_test/flutter_test.dart';
import 'package:lingo_notes/features/texts/domain/dialogue.dart';
import 'package:lingo_notes/features/texts/domain/dialogue_reader.dart';

void main() {
  const line = DialogueLine(
    id: 'line-1',
    speaker: 'A',
    segments: [
      DialogueSegment(
        id: 's1',
        english: 'How are you',
        portuguese: 'Como você',
      ),
      DialogueSegment(id: 's2', english: 'today', portuguese: 'está hoje'),
    ],
    englishTokens: [
      DialogueToken.segment('s1'),
      DialogueToken.text(' '),
      DialogueToken.segment('s2'),
      DialogueToken.text('?'),
    ],
    portugueseTokens: [
      DialogueToken.segment('s1'),
      DialogueToken.text(' '),
      DialogueToken.segment('s2'),
      DialogueToken.text('?'),
    ],
  );

  test('monta o texto falado somente com os tokens em inglês', () {
    expect(buildLineText(line, DialogueLanguage.english), 'How are you today?');
  });

  test('respeita ordens diferentes dos tokens em cada idioma', () {
    const reordered = DialogueLine(
      id: 'line-2',
      speaker: null,
      segments: [
        DialogueSegment(id: 's1', english: 'I like', portuguese: 'Eu gosto'),
        DialogueSegment(
          id: 's2',
          english: 'this game',
          portuguese: 'deste jogo',
        ),
      ],
      englishTokens: [
        DialogueToken.segment('s1'),
        DialogueToken.text(' '),
        DialogueToken.segment('s2'),
      ],
      portugueseTokens: [
        DialogueToken.segment('s2'),
        DialogueToken.text(', '),
        DialogueToken.segment('s1'),
      ],
    );

    expect(
      buildLineText(reordered, DialogueLanguage.english),
      'I like this game',
    );
    expect(
      buildLineText(reordered, DialogueLanguage.portuguese),
      'deste jogo, Eu gosto',
    );
  });

  test('localiza o par alinhado pelo mesmo segmentId', () {
    final segment = findAlignedSegment(line, 's2');

    expect(segment.english, 'today');
    expect(segment.portuguese, 'está hoje');
  });

  test('separa as linhas do texto completo sem incluir IDs ou tradução', () {
    const document = DialogueDocument(
      format: 'english-notebook-dialogue',
      version: '1.0',
      sourceId: 'source',
      title: 'Title',
      contentType: DialogueContentType.dialogue,
      sourceLanguage: 'en-US',
      targetLanguage: 'pt-BR',
      level: null,
      tags: [],
      lines: [line, line],
    );

    expect(
      buildEnglishSpeech(document),
      'How are you today?\nHow are you today?',
    );
  });
}
