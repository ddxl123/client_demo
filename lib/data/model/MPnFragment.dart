// ignore_for_file: non_constant_identifier_names
    import 'package:demo/data/sqlite/sqliter/OpenSqlite.dart';
    import 'ModelBase.dart';
    
class MPnFragment implements ModelBase{
  MPnFragment();
  MPnFragment.createModel({
          required int? id,
                required int? aiid,
                required String? uuid,
                required int? created_at,
                required int? updated_at,
                required int? used_rule_aiid,
                required String? easy_position,
                required String? title,
        
  }) {
    _rowJson.addAll(
      <String, Object?>{
                'id': id,
              'aiid': aiid,
              'uuid': uuid,
              'created_at': created_at,
              'updated_at': updated_at,
              'used_rule_aiid': used_rule_aiid,
              'easy_position': easy_position,
              'title': title,
      
      },
    );
  }
  
    String get tableName => 'pn_fragment';
    
      String get id => 'id';
            String get aiid => 'aiid';
            String get uuid => 'uuid';
            String get created_at => 'created_at';
            String get updated_at => 'updated_at';
            String get used_rule_aiid => 'used_rule_aiid';
            String get easy_position => 'easy_position';
            String get title => 'title';
      
  final Map<String, Object?> _rowJson = <String, Object?>{};
  
  @override
  Map<String, Object?> get getRowJson => _rowJson;
    
      int? get get_id => _rowJson['id'] as int?;
            int? get get_aiid => _rowJson['aiid'] as int?;
            String? get get_uuid => _rowJson['uuid'] as String?;
            int? get get_created_at => _rowJson['created_at'] as int?;
            int? get get_updated_at => _rowJson['updated_at'] as int?;
            int? get get_used_rule_aiid => _rowJson['used_rule_aiid'] as int?;
            String? get get_easy_position => _rowJson['easy_position'] as String?;
            String? get get_title => _rowJson['title'] as String?;
      
    Set<String> getDeleteManyForTwo() => <String>{
              'f_fragment.node',
        
    };    
    
    Set<String> getDeleteManyForSingle() => <String>{
      
    };    
    
  Future<int> insertDb() async {
    return await db.insert(tableName, _rowJson);
  }
    
}
