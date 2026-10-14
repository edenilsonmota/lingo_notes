import 'dart:convert';

import 'dialogue.dart';

class DialogueValidationIssue {
  const DialogueValidationIssue(this.path, this.message);

  final String path;
  final String message;

  @override
  String toString() => '$path: $message';
}

class DialogueValidationException implements Exception {
  const DialogueValidationException(this.issues);

  final List<DialogueValidationIssue> issues;

  @override
  String toString() => issues.join('\n');
}

class DialogueParser {
  const DialogueParser();

  static final _segmentIdPattern = RegExp(r'^[A-Za-z][A-Za-z0-9_-]*$');

  DialogueDocument parse(String source) {
    final dynamic decoded;
    try {
      decoded = jsonDecode(source);
    } on FormatException {
      throw const DialogueValidationException([
        DialogueValidationIssue(r'$', 'O conteúdo não é um JSON válido.'),
      ]);
    }

    if (decoded is! Map<String, dynamic>) {
      throw const DialogueValidationException([
        DialogueValidationIssue(r'$', 'O documento deve ser um objeto JSON.'),
      ]);
    }

    final issues = <DialogueValidationIssue>[];
    _validateDocument(decoded, issues);
    if (issues.isNotEmpty) {
      throw DialogueValidationException(List.unmodifiable(issues));
    }

    return _readDocument(decoded);
  }

  void _validateDocument(
    Map<String, dynamic> json,
    List<DialogueValidationIssue> issues,
  ) {
    const required = {
      'format',
      'version',
      'id',
      'title',
      'contentType',
      'sourceLanguage',
      'targetLanguage',
      'lines',
    };
    const allowed = {...required, 'level', 'tags'};
    _validateProperties(json, r'$', required, allowed, issues);

    if (json.containsKey('format')) {
      _expectConstant(
        json['format'],
        r'$.format',
        'english-notebook-dialogue',
        issues,
      );
    }
    if (json.containsKey('version')) {
      _expectConstant(json['version'], r'$.version', '1.0', issues);
    }
    if (json.containsKey('id')) {
      _expectNonEmptyString(json['id'], r'$.id', issues);
    }
    if (json.containsKey('title')) {
      _expectNonEmptyString(json['title'], r'$.title', issues);
    }
    if (json.containsKey('contentType')) {
      _expectEnum(json['contentType'], r'$.contentType', const {
        'dialogue',
        'narrative',
      }, issues);
    }
    if (json.containsKey('sourceLanguage')) {
      _expectConstant(
        json['sourceLanguage'],
        r'$.sourceLanguage',
        'en-US',
        issues,
      );
    }
    if (json.containsKey('targetLanguage')) {
      _expectConstant(
        json['targetLanguage'],
        r'$.targetLanguage',
        'pt-BR',
        issues,
      );
    }

    if (json.containsKey('level') && json['level'] is! String) {
      issues.add(
        const DialogueValidationIssue(r'$.level', 'Deve ser um texto.'),
      );
    }
    _validateTags(json['tags'], json.containsKey('tags'), issues);
    if (json.containsKey('lines')) {
      _validateLines(json['lines'], issues);
    }
  }

  void _validateTags(
    dynamic value,
    bool isPresent,
    List<DialogueValidationIssue> issues,
  ) {
    if (!isPresent) return;
    if (value is! List<dynamic>) {
      issues.add(
        const DialogueValidationIssue(r'$.tags', 'Deve ser uma lista.'),
      );
      return;
    }

    final seen = <String>{};
    for (var index = 0; index < value.length; index++) {
      final tag = value[index];
      final path =
          r'$.tags'
          '[$index]';
      if (tag is! String || tag.isEmpty) {
        issues.add(
          DialogueValidationIssue(path, 'Deve ser um texto não vazio.'),
        );
      } else if (!seen.add(tag)) {
        issues.add(
          DialogueValidationIssue(path, 'A tag “$tag” está duplicada.'),
        );
      }
    }
  }

  void _validateLines(dynamic value, List<DialogueValidationIssue> issues) {
    if (value is! List<dynamic>) {
      issues.add(
        const DialogueValidationIssue(r'$.lines', 'Deve ser uma lista.'),
      );
      return;
    }
    if (value.isEmpty) {
      issues.add(
        const DialogueValidationIssue(
          r'$.lines',
          'Informe pelo menos uma linha.',
        ),
      );
    }

    final lineIds = <String>{};
    for (var index = 0; index < value.length; index++) {
      final path =
          r'$.lines'
          '[$index]';
      final line = _expectObject(value[index], path, issues);
      if (line == null) continue;
      _validateLine(line, path, lineIds, issues);
    }
  }

  void _validateLine(
    Map<String, dynamic> line,
    String path,
    Set<String> lineIds,
    List<DialogueValidationIssue> issues,
  ) {
    const required = {'id', 'segments', 'en', 'pt'};
    const allowed = {...required, 'speaker'};
    _validateProperties(line, path, required, allowed, issues);

    if (line.containsKey('id')) {
      final id = line['id'];
      _expectNonEmptyString(id, '$path.id', issues);
      if (id is String && id.isNotEmpty && !lineIds.add(id)) {
        issues.add(
          DialogueValidationIssue(
            '$path.id',
            'O ID de linha “$id” está duplicado.',
          ),
        );
      }
    }
    if (line.containsKey('speaker')) {
      _expectNonEmptyString(line['speaker'], '$path.speaker', issues);
    }

    final segmentIds = line.containsKey('segments')
        ? _validateSegments(line['segments'], path, issues)
        : <String>{};
    if (line.containsKey('en')) {
      _validateTokens(line['en'], '$path.en', segmentIds, issues);
    }
    if (line.containsKey('pt')) {
      _validateTokens(line['pt'], '$path.pt', segmentIds, issues);
    }
  }

  Set<String> _validateSegments(
    dynamic value,
    String linePath,
    List<DialogueValidationIssue> issues,
  ) {
    final path = '$linePath.segments';
    final ids = <String>{};
    if (value is! List<dynamic>) {
      issues.add(DialogueValidationIssue(path, 'Deve ser uma lista.'));
      return ids;
    }
    if (value.isEmpty) {
      issues.add(
        DialogueValidationIssue(path, 'Informe pelo menos um segmento.'),
      );
    }

    for (var index = 0; index < value.length; index++) {
      final segmentPath = '$path[$index]';
      final segment = _expectObject(value[index], segmentPath, issues);
      if (segment == null) continue;
      const properties = {'id', 'en', 'pt'};
      _validateProperties(segment, segmentPath, properties, properties, issues);

      if (segment.containsKey('id')) {
        final id = segment['id'];
        _expectSegmentId(id, '$segmentPath.id', issues);
        if (id is String && _segmentIdPattern.hasMatch(id) && !ids.add(id)) {
          issues.add(
            DialogueValidationIssue(
              '$segmentPath.id',
              'O ID de segmento “$id” está duplicado nesta linha.',
            ),
          );
        }
      }
      if (segment.containsKey('en')) {
        _expectNonEmptyString(segment['en'], '$segmentPath.en', issues);
      }
      if (segment.containsKey('pt')) {
        _expectNonEmptyString(segment['pt'], '$segmentPath.pt', issues);
      }
    }
    return ids;
  }

  void _validateTokens(
    dynamic value,
    String path,
    Set<String> segmentIds,
    List<DialogueValidationIssue> issues,
  ) {
    if (value is! List<dynamic>) {
      issues.add(DialogueValidationIssue(path, 'Deve ser uma lista.'));
      return;
    }
    if (value.isEmpty) {
      issues.add(DialogueValidationIssue(path, 'Informe pelo menos um token.'));
    }

    for (var index = 0; index < value.length; index++) {
      final tokenPath = '$path[$index]';
      final token = _expectObject(value[index], tokenPath, issues);
      if (token == null) continue;

      const allowed = {'segmentId', 'text'};
      final unknown = token.keys.where((key) => !allowed.contains(key));
      for (final key in unknown) {
        issues.add(
          DialogueValidationIssue('$tokenPath.$key', 'Campo não permitido.'),
        );
      }

      final hasSegment = token.containsKey('segmentId');
      final hasText = token.containsKey('text');
      if (hasSegment == hasText) {
        issues.add(
          DialogueValidationIssue(
            tokenPath,
            'Use somente “segmentId” ou somente “text”.',
          ),
        );
        continue;
      }

      if (hasSegment) {
        final segmentId = token['segmentId'];
        _expectSegmentId(segmentId, '$tokenPath.segmentId', issues);
        if (segmentId is String &&
            _segmentIdPattern.hasMatch(segmentId) &&
            !segmentIds.contains(segmentId)) {
          issues.add(
            DialogueValidationIssue(
              '$tokenPath.segmentId',
              'O segmento “$segmentId” não existe nesta linha.',
            ),
          );
        }
      } else {
        _expectNonEmptyString(token['text'], '$tokenPath.text', issues);
      }
    }
  }

  Map<String, dynamic>? _expectObject(
    dynamic value,
    String path,
    List<DialogueValidationIssue> issues,
  ) {
    if (value is Map<String, dynamic>) return value;
    issues.add(DialogueValidationIssue(path, 'Deve ser um objeto.'));
    return null;
  }

  void _validateProperties(
    Map<String, dynamic> json,
    String path,
    Set<String> required,
    Set<String> allowed,
    List<DialogueValidationIssue> issues,
  ) {
    for (final field in required) {
      if (!json.containsKey(field)) {
        issues.add(
          DialogueValidationIssue('$path.$field', 'Campo obrigatório ausente.'),
        );
      }
    }
    for (final field in json.keys) {
      if (!allowed.contains(field)) {
        issues.add(
          DialogueValidationIssue('$path.$field', 'Campo não permitido.'),
        );
      }
    }
  }

  void _expectConstant(
    dynamic value,
    String path,
    String expected,
    List<DialogueValidationIssue> issues,
  ) {
    if (value != expected) {
      issues.add(
        DialogueValidationIssue(path, 'Deve ser exatamente “$expected”.'),
      );
    }
  }

  void _expectEnum(
    dynamic value,
    String path,
    Set<String> values,
    List<DialogueValidationIssue> issues,
  ) {
    if (value is! String || !values.contains(value)) {
      issues.add(
        DialogueValidationIssue(
          path,
          'Use um destes valores: ${values.join(', ')}.',
        ),
      );
    }
  }

  void _expectNonEmptyString(
    dynamic value,
    String path,
    List<DialogueValidationIssue> issues,
  ) {
    if (value is! String || value.isEmpty) {
      issues.add(DialogueValidationIssue(path, 'Deve ser um texto não vazio.'));
    }
  }

  void _expectSegmentId(
    dynamic value,
    String path,
    List<DialogueValidationIssue> issues,
  ) {
    if (value is! String || !_segmentIdPattern.hasMatch(value)) {
      issues.add(
        DialogueValidationIssue(
          path,
          'Use letras, números, “_” ou “-”, começando por uma letra.',
        ),
      );
    }
  }

  DialogueDocument _readDocument(Map<String, dynamic> json) {
    return DialogueDocument(
      format: json['format'] as String,
      version: json['version'] as String,
      sourceId: json['id'] as String,
      title: json['title'] as String,
      contentType: DialogueContentType.fromStorage(
        json['contentType'] as String,
      ),
      sourceLanguage: json['sourceLanguage'] as String,
      targetLanguage: json['targetLanguage'] as String,
      level: json['level'] as String?,
      tags: (json['tags'] as List<dynamic>? ?? const []).cast<String>().toList(
        growable: false,
      ),
      lines: (json['lines'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map(_readLine)
          .toList(growable: false),
    );
  }

  DialogueLine _readLine(Map<String, dynamic> json) {
    return DialogueLine(
      id: json['id'] as String,
      speaker: json['speaker'] as String?,
      segments: (json['segments'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map(
            (segment) => DialogueSegment(
              id: segment['id'] as String,
              english: segment['en'] as String,
              portuguese: segment['pt'] as String,
            ),
          )
          .toList(growable: false),
      englishTokens: _readTokens(json['en'] as List<dynamic>),
      portugueseTokens: _readTokens(json['pt'] as List<dynamic>),
    );
  }

  List<DialogueToken> _readTokens(List<dynamic> tokens) {
    return tokens
        .cast<Map<String, dynamic>>()
        .map((token) {
          if (token.containsKey('segmentId')) {
            return DialogueToken.segment(token['segmentId'] as String);
          }
          return DialogueToken.text(token['text'] as String);
        })
        .toList(growable: false);
  }
}
