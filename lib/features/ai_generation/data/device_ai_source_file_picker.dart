import 'dart:convert';

import 'package:file_picker/file_picker.dart';

import '../domain/ai_source_file_picker.dart';

class DeviceAiSourceFilePicker implements AiSourceFilePicker {
  const DeviceAiSourceFilePicker();

  @override
  Future<PickedAiSourceFile?> pickTextOrMarkdown() async {
    final file = await FilePicker.pickFile(
      dialogTitle: 'Selecionar texto para gerar com IA',
      type: FileType.custom,
      allowedExtensions: const ['txt', 'md'],
    );
    if (file == null) return null;
    return PickedAiSourceFile(
      name: file.name,
      content: utf8.decode(await file.readAsBytes()),
    );
  }
}
