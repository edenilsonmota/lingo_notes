import 'dart:convert';

import '../../texts/domain/dialogue_parser.dart';

String updateGeneratedDialogueTitle({
  required String sourceJson,
  required String title,
  DialogueParser parser = const DialogueParser(),
}) {
  final trimmedTitle = title.trim();
  if (trimmedTitle.isEmpty) {
    throw const AiGeneratedTitleException('Informe um título.');
  }
  final decoded = jsonDecode(sourceJson);
  if (decoded is! Map<String, dynamic>) {
    throw const AiGeneratedTitleException('A prévia gerada é inválida.');
  }
  decoded['title'] = trimmedTitle;
  final updated = jsonEncode(decoded);
  parser.parse(updated);
  return updated;
}

class AiGeneratedTitleException implements Exception {
  const AiGeneratedTitleException(this.message);

  final String message;

  @override
  String toString() => message;
}
