        import 'package:sqflite/sqflite.dart';
    import 'package:demo/data/sqlite/sqliter/OpenSqlite.dart';
    import 'ModelBase.dart';
          import 'MAppVersionInfo.dart';
            import 'MUpload.dart';
            import 'MUser.dart';
            import 'MFComplete.dart';
            import 'MFFragment.dart';
            import 'MFMemory.dart';
            import 'MFRule.dart';
            import 'MPnComplete.dart';
            import 'MPnFragment.dart';
            import 'MPnMemory.dart';
            import 'MPnRule.dart';
      
    
    class ModelManager {
          static T createEmptyModelByTableName<T extends ModelBase>(String tableName) {
      switch (tableName) {
              case 'app_version_info':
        return MAppVersionInfo() as T;
            case 'upload':
        return MUpload() as T;
            case 'user':
        return MUser() as T;
            case 'f_complete':
        return MFComplete() as T;
            case 'f_fragment':
        return MFFragment() as T;
            case 'f_memory':
        return MFMemory() as T;
            case 'f_rule':
        return MFRule() as T;
            case 'pn_complete':
        return MPnComplete() as T;
            case 'pn_fragment':
        return MPnFragment() as T;
            case 'pn_memory':
        return MPnMemory() as T;
            case 'pn_rule':
        return MPnRule() as T;
      
        default:
          throw 'unknown tableName: ' + tableName;
      }
    }
    
            /// 参数除了 connectTransaction，其他的与 db.query 相同
      static Future<List<Map<String, Object?>>> queryRowsAsJsons({
        required Transaction? connectTransaction,
        required String tableName,
        bool? distinct,
        List<String>? columns,
        String? where,
        List<Object?>? whereArgs,
        String? groupBy,
        String? having,
        String? orderBy,
        int? limit,
        int? offset,
      }) async {
        if (connectTransaction != null) {
          return await connectTransaction.query(
            tableName,
            distinct: distinct,
            columns: columns,
            where: where,
            whereArgs: whereArgs,
            groupBy: groupBy,
            having: having,
            orderBy: orderBy,
            limit: limit,
            offset: offset,
          );
        }
        return await db.query(
          tableName,
          distinct: distinct,
          columns: columns,
          where: where,
          whereArgs: whereArgs,
          groupBy: groupBy,
          having: having,
          orderBy: orderBy,
          limit: limit,
          offset: offset,
        );
      }
    
        /// [returnWhere]: 对每个 model 进行格外操作。
  static Future<List<M>> queryRowsAsModels<M extends ModelBase>({
    required Transaction? connectTransaction,
    required String tableName,
    void Function(M model)? returnWhere,
    bool? distinct,
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    final List<Map<String, Object?>> rows = await queryRowsAsJsons(
      connectTransaction: connectTransaction,
      tableName: tableName,
      distinct: distinct,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
      groupBy: groupBy,
      having: having,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );

    final List<M> models = <M>[];
    for (final Map<String, Object?> row in rows) {
      final M neModel = createEmptyModelByTableName<M>(tableName);
      neModel.getRowJson.addAll(row);
      models.add(neModel);
      returnWhere?.call(neModel);
    }
    return models;
  }
    
    }
    