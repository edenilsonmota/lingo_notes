class DialogueDocument {
  const DialogueDocument({
    required this.format,
    required this.version,
    required this.sourceId,
    required this.title,
    required this.contentType,
    required this.sourceLanguage,
    required this.targetLanguage,
    required this.level,
    required this.tags,
    required this.lines,
  });

  final String format;
  final String version;
  final String sourceId;
  final DialogueContentType contentType;
  final String title;
  final String sourceLanguage;
  final String targetLanguage;
  final String? level;
  final List<String> tags;
  final List<DialogueLine> lines;
}

enum DialogueContentType {
  dialogue,
  narrative;

  static DialogueContentType fromStorage(String value) {
    return DialogueContentType.values.firstWhere((type) => type.name == value);
  }
}

class DialogueLine {
  const DialogueLine({
    required this.id,
    required this.speaker,
    required this.segments,
    required this.englishTokens,
    required this.portugueseTokens,
  });

  final String id;
  final String? speaker;
  final List<DialogueSegment> segments;
  final List<DialogueToken> englishTokens;
  final List<DialogueToken> portugueseTokens;
}

class DialogueSegment {
  const DialogueSegment({
    required this.id,
    required this.english,
    required this.portuguese,
  });

  final String id;
  final String english;
  final String portuguese;
}

class DialogueToken {
  const DialogueToken.segment(this.segmentId) : text = null;

  const DialogueToken.text(this.text) : segmentId = null;

  final String? segmentId;
  final String? text;

  bool get isSegment => segmentId != null;
}

class ImportedText {
  const ImportedText({
    required this.id,
    required this.notebookId,
    required this.dialogue,
    required this.sourceJson,
    required this.importedAt,
  });

  final String id;
  final String notebookId;
  final DialogueDocument dialogue;
  final String sourceJson;
  final DateTime importedAt;
}
