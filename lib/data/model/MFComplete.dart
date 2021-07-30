// ignore_for_file: non_constant_identifier_names
    import 'package:demo/data/sqlite/sqliter/OpenSqlite.dart';
    import 'ModelBase.dart';
    
class MFComplete implements ModelBase{
  MFComplete();
  MFComplete.createModel({
          required int? id,
                required int? aiid,
                required String? uuid,
                required int? created_at,
                required int? updated_at,
                required String? title,
                required int? node_aiid,
                required String? node_uuid,
        
  }) {
    _rowJson.addAll(
      <String, Object?>{
                'id': id,
              'aiid': aiid,
              'uuid': uuid,
              'created_at': created_at,
              'updated_at': updated_at,
              'title': title,
              'node_aiid': node_aiid,
              'node_uuid': node_uuid,
      
      },
    );
  }
  
    String get tableName => 'f_complete';
    
      String get id => 'id';
            String get aiid => 'aiid';
            String get uuid => 'uuid';
            String get created_at => 'created_at';
            String get updated_at => 'updated_at';
            String get title => 'title';
            String get node_aiid => 'node_aiid';
            String get node_uuid => 'node_uuid';
      
  final Map<String, Object?> _rowJson = <String, Object?>{};
  
  @override
  Map<String, Object?> get getRowJson => _rowJson;
    
      int? get get_id => _rowJson['id'] as int?;
            int? get get_aiid => _rowJson['aiid'] as int?;
            String? get get_uuid => _rowJson['uuid'] as String?;
            int? get get_created_at => _rowJson['created_at'] as int?;
            int? get get_updated_at => _rowJson['updated_at'] as int?;
            String? get get_title => _rowJson['title'] as String?;
            int? get get_node_aiid => _rowJson['node_aiid'] as int?;
            String? get get_node_uuid => _rowJson['node_uuid'] as String?;
      
    Set<String> getDeleteManyForTwo() => <String>{
      
    };    
    
    Set<String> getDeleteManyForSingle() => <String>{
      
    };    
    
  Future<int> insertDb() async {
    return await db.insert(tableName, _rowJson);
  }
    
}
