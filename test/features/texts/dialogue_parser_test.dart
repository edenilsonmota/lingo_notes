import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:lingo_notes/features/texts/domain/dialogue.dart';
import 'package:lingo_notes/features/texts/domain/dialogue_file_picker.dart';
import 'package:lingo_notes/features/texts/domain/dialogue_parser.dart';
import 'package:lingo_notes/features/texts/domain/import_dialogue_file.dart';
import 'package:lingo_notes/features/texts/domain/text_repository.dart';

void main() {
  const parser = DialogueParser();

  test('aceita um documento v1.0 válido', () {
    final dialogue = parser.parse(jsonEncode(validDialogueJson()));

    expect(dialogue.sourceId, 'free-time-conversation');
    expect(dialogue.title, 'Free-time conversation');
    expect(dialogue.contentType, DialogueContentType.dialogue);
    expect(dialogue.lines.single.segments, hasLength(2));
    expect(dialogue.tags, ['free time', 'games']);
  });

  test('rejeita JSON malformado', () {
    final issues = validationIssues(() => parser.parse('{"format":'));

    expect(issues.single.message, contains('não é um JSON válido'));
  });

  test('rejeita formato e versão diferentes', () {
    final json = validDialogueJson()
      ..['format'] = 'outro-formato'
      ..['version'] = '2.0';

    final issues = validationIssues(() => parser.parse(jsonEncode(json)));

    expect(
      issues.map((issue) => issue.path),
      containsAll([r'$.format', r'$.version']),
    );
  });

  test('rejeita campos obrigatórios ausentes e propriedades extras', () {
    final json = validDialogueJson()
      ..remove('title')
      ..['unexpected'] = true;

    final issues = validationIssues(() => parser.parse(jsonEncode(json)));

    expect(
      issues.map((issue) => issue.path),
      containsAll([r'$.title', r'$.unexpected']),
    );
  });

  test('rejeita IDs de linha duplicados', () {
    final json = validDialogueJson();
    final lines = List<dynamic>.from(json['lines']! as List<dynamic>);
    json['lines'] = lines;
    lines.add(Map<String, dynamic>.from(lines.first as Map<String, dynamic>));

    final issues = validationIssues(() => parser.parse(jsonEncode(json)));

    expect(
      issues.any(
        (issue) =>
            issue.message.contains('linha') &&
            issue.message.contains('duplicado'),
      ),
      isTrue,
    );
  });

  test('rejeita IDs de segmento duplicados na mesma linha', () {
    final json = validDialogueJson();
    final line =
        (json['lines']! as List<dynamic>).first as Map<String, dynamic>;
    final segments = line['segments']! as List<dynamic>;
    segments.add({'id': 's1', 'en': 'again', 'pt': 'novamente'});

    final issues = validationIssues(() => parser.parse(jsonEncode(json)));

    expect(
      issues.any(
        (issue) =>
            issue.message.contains('segmento') &&
            issue.message.contains('duplicado'),
      ),
      isTrue,
    );
  });

  test('rejeita referência a segmento inexistente', () {
    final json = validDialogueJson();
    final line =
        (json['lines']! as List<dynamic>).first as Map<String, dynamic>;
    (line['pt']! as List<dynamic>).add({'segmentId': 'missing'});

    final issues = validationIssues(() => parser.parse(jsonEncode(json)));

    expect(issues.any((issue) => issue.message.contains('não existe')), isTrue);
  });

  test('rejeita token que mistura segmentId e text', () {
    final json = validDialogueJson();
    final line =
        (json['lines']! as List<dynamic>).first as Map<String, dynamic>;
    (line['en']! as List<dynamic>)[0] = {'segmentId': 's1', 'text': 'invalid'};

    final issues = validationIssues(() => parser.parse(jsonEncode(json)));

    expect(issues.any((issue) => issue.message.contains('somente')), isTrue);
  });

  test('não persiste quando o arquivo é inválido', () async {
    final repository = RecordingTextRepository();
    final importer = ImportDialogueFile(repository);
    final file = PickedDialogueFile(
      name: 'invalid.json',
      bytes: Uint8List.fromList(utf8.encode('{"invalid":true}')),
    );

    await expectLater(
      importer(notebookId: 'notebook-1', file: file),
      throwsA(isA<DialogueValidationException>()),
    );
    expect(repository.saved, isEmpty);
  });
}

List<DialogueValidationIssue> validationIssues(void Function() action) {
  try {
    action();
  } on DialogueValidationException catch (error) {
    return error.issues;
  }
  fail('Era esperada uma DialogueValidationException.');
}

Map<String, dynamic> validDialogueJson() {
  return {
    'format': 'english-notebook-dialogue',
    'version': '1.0',
    'id': 'free-time-conversation',
    'title': 'Free-time conversation',
    'contentType': 'dialogue',
    'sourceLanguage': 'en-US',
    'targetLanguage': 'pt-BR',
    'level': 'A2',
    'tags': ['free time', 'games'],
    'lines': [
      {
        'id': 'line-001',
        'speaker': 'A',
        'segments': [
          {
            'id': 's1',
            'en': 'What do you like to do',
            'pt': 'O que você gosta de fazer',
          },
          {'id': 's2', 'en': 'in your free time', 'pt': 'no seu tempo livre'},
        ],
        'en': [
          {'segmentId': 's1'},
          {'text': ' '},
          {'segmentId': 's2'},
          {'text': '?'},
        ],
        'pt': [
          {'segmentId': 's1'},
          {'text': ' '},
          {'segmentId': 's2'},
          {'text': '?'},
        ],
      },
    ],
  };
}

class RecordingTextRepository implements TextRepository {
  final saved = <ImportedText>[];

  @override
  Future<void> save({
    required String notebookId,
    required DialogueDocument dialogue,
    required String sourceJson,
  }) async {
    saved.add(
      ImportedText(
        id: 'generated-id',
        notebookId: notebookId,
        dialogue: dialogue,
        sourceJson: sourceJson,
        importedAt: DateTime.utc(2026, 10, 14),
      ),
    );
  }

  @override
  Stream<List<ImportedText>> watchByNotebook(String notebookId) {
    return Stream.value(List.unmodifiable(saved));
  }
}
