import 'package:isar_community/isar.dart';

part 'imported_text_record.g.dart';

@collection
class ImportedTextRecord {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uuid;

  @Index()
  late String notebookId;

  late String sourceId;
  late String title;
  late String contentType;
  late String sourceLanguage;
  late String targetLanguage;
  String? level;
  List<String> tags = const [];
  late String sourceJson;
  late DateTime importedAt;
}
