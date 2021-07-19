import 'package:demo/util/sblogger/SbLogger.dart';

import 'OpenSqlite.dart';

/// 通用工具
class SqliteTool {
  ///

  /// 获取全部的表, 不包含 android_metadata
  Future<List<String>> getAllTableNames() async {
    final List<String> tableNames = (await db.query(
      'sqlite_master',
      where: 'type = ?',
      whereArgs: <Object?>['table'],
    ))
        .map((Map<String, Object?> row) => row['name']! as String)
        .toList();
    tableNames.remove('android_metadata');
    tableNames.remove('sqlite_sequence');
    return tableNames;
  }

  /// 移除指定表。
  Future<void> dropTable(String tableName) async {
    await db.execute('DROP TABLE IF EXISTS $tableName');
  }

  /// 移除全部表。
  Future<void> dropAllTable() async {
    final List<String> tablesBefore = await getAllTableNames();
    sbLogger(message: '移除前的表：$tablesBefore');

    // 将存在的表全部移除。
    for (int i = 0; i < tablesBefore.length; i++) {
      await dropTable(tablesBefore[i]);
    }

    final List<String> tablesAfter = await getAllTableNames();
    sbLogger(message: '移除后的表：$tablesAfter');
  }

  /// 创建全部需要的表
  Future<void> createAllTables(Map<String, String> sqls) async {
    for (int i = 0; i < sqls.length; i++) {
      await db.execute(sqls.values.elementAt(i));
    }
    final List<String> result = await SqliteTool().getAllTableNames();
    sbLogger(message: '创建全部需要的表完成：$result');
  }

  /// 获取某表的全部字段信息
  Future<List<Map<String, Object?>>> getTableInfo(String tableName) async {
    return await db.rawQuery('PRAGMA table_info($tableName)');
  }
}
