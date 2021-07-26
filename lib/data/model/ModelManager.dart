        import 'package:sqflite/sqflite.dart';
    import 'package:demo/data/sqlite/sqliter/OpenSqlite.dart';
    import 'ModelBase.dart';
          import 'FComplete.dart';
            import 'FFragment.dart';
            import 'FMemory.dart';
            import 'FRule.dart';
            import 'AppVersionInfo.dart';
            import 'User.dart';
            import 'PnComplete.dart';
            import 'PnFragment.dart';
            import 'PnMemory.dart';
            import 'PnRule.dart';
      
    
    class ModelManager {
          static T createEmptyModelByTableName<T extends ModelBase>(String tableName) {
      switch (tableName) {
              case 'f_complete':
        return FComplete() as T;
            case 'f_fragment':
        return FFragment() as T;
            case 'f_memory':
        return FMemory() as T;
            case 'f_rule':
        return FRule() as T;
            case 'app_version_info':
        return AppVersionInfo() as T;
            case 'user':
        return User() as T;
            case 'pn_complete':
        return PnComplete() as T;
            case 'pn_fragment':
        return PnFragment() as T;
            case 'pn_memory':
        return PnMemory() as T;
            case 'pn_rule':
        return PnRule() as T;
      
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
    