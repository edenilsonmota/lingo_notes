class PickedAiSourceFile {
  const PickedAiSourceFile({required this.name, required this.content});

  final String name;
  final String content;
}

abstract interface class AiSourceFilePicker {
  Future<PickedAiSourceFile?> pickTextOrMarkdown();
}
