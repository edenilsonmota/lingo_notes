import 'dart:typed_data';

class PickedDialogueFile {
  const PickedDialogueFile({required this.name, required this.bytes});

  final String name;
  final Uint8List bytes;
}

abstract interface class DialogueFilePicker {
  Future<PickedDialogueFile?> pickJson();
}
