import 'package:file_picker/file_picker.dart';

import '../domain/dialogue_file_picker.dart';

class DeviceDialogueFilePicker implements DialogueFilePicker {
  const DeviceDialogueFilePicker();

  @override
  Future<PickedDialogueFile?> pickJson() async {
    final file = await FilePicker.pickFile(
      dialogTitle: 'Importar texto do Lingo Notes',
      type: FileType.custom,
      allowedExtensions: const ['json'],
    );
    if (file == null) return null;

    return PickedDialogueFile(name: file.name, bytes: await file.readAsBytes());
  }
}
