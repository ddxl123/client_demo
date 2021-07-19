class ModelBaseContent {
  ModelBaseContent({required this.folderPath});

  final String folderPath;

  String content() {
    return '''
    // ignore_for_file: non_constant_identifier_names
    abstract class ModelBase {
      Map<String, Object?> get getRowJson;
    }
    ''';
  }
}
