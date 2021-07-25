// ignore_for_file: non_constant_identifier_names

import 'dart:io';


import 'Member.dart';
import 'content/ModelBaseContent.dart';
import 'content/ModelContent.dart';
import 'content/ModelManagerContent.dart';
import 'content/ParseIntoSqlsContent.dart';
import 'content/Util.dart';
import 'creator/ModelCreator.dart';

class Writer {
  Writer({
    required this.folderPath,
    required this.models,
  }) {
    writer();
  }

  /// 要输出的文件夹的绝对路径。
  String folderPath;
  List<ModelCreator> models;

  Future<void> writer() async {
    await setPath();
    await runWriteModels();
    await runWriteModelBase();
    await runWriteModelManager();
    await runParseIntoSqls();
  }

  Future<void> setPath() async {
    // ignore: avoid_slow_async_io
    if (await Directory(folderPath).exists()) {
      throw '文件夹已存在！';
    } else {
      await Directory(folderPath).create();
    }
  }

  Future<void> runWriteModels() async {
    for (int i = 0; i < modelFields.length; i++) {
      final String tableName = modelFields.keys.elementAt(i);
      final Map<String, List<Object>> fields = modelFields[tableName]!;

      await File('$folderPath/${toCamelCase(tableName)}.dart').writeAsString(
          ModelContent(
                  folderPath: folderPath, tableName: tableName, fields: fields)
              .content());
      print("Named '$tableName''s model file is created successfully!");
    }
  }

  Future<void> runWriteModelBase() async {
    await File('$folderPath/ModelBase.dart')
        .writeAsString(ModelBaseContent(folderPath: folderPath).content());
    print("'ModelBase' file is created successfully!");
  }

  Future<void> runWriteModelManager() async {
    await File('$folderPath/ModelManager.dart')
        .writeAsString(ModelManagerContent(folderPath: folderPath).content());
    print("'ModelManager' file is created successfully!");
  }

  Future<void> runParseIntoSqls() async {
    final Map<String, String> rawSqls = <String, String>{};
    modelFields.forEach(
      (String tableName, Map<String, List<String>> fieldTypes) {
        String rawFieldsSql =
            ''; // 最终: "CREATE TABLE table_name (username TEXT UNIQUE,password TEXT,),"
        fieldTypes.forEach(
          (String fieldName, List<String> fieldTypes) {
            String rawFieldSql = fieldName;
            final List<String> newFieldTypes =
                fieldTypes.sublist(0, fieldTypes.length - 1);
            for (final String fieldType in newFieldTypes) {
              rawFieldSql += ' ' + fieldType; // 形成 "username TEXT UNIQUE,"
            }
            rawFieldsSql +=
                '$rawFieldSql,'; // 形成 "username TEXT UNIQUE,password TEXT,"
          },
        );
        rawFieldsSql = rawFieldsSql.replaceAll(RegExp(r',$'), ''); // 去掉结尾逗号
        rawSqls.addAll(<String, String>{
          tableName: 'CREATE TABLE $tableName ($rawFieldsSql)'
        }); // 形成 "CREATE TABLE table_name (username TEXT UNIQUE,password TEXT,),"
      },
    );

    await File('$folderPath/ParseIntoSqls.dart').writeAsString(
        ParseIntoSqlsContent(rawSqls: rawSqls).parseIntoSqlsContent());
    print("'ParseIntoSqls' file is created successfully!");
  }
}
