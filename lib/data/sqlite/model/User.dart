// ignore_for_file: non_constant_identifier_names
    import 'ModelBase.dart';
    
class User implements ModelBase{
    String get tableName => 'user';
    
      String get id => 'id';
            String get aiid => 'aiid';
            String get uuid => 'uuid';
            String get created_at => 'created_at';
            String get updated_at => 'updated_at';
      
  final Map<String, Object?> _rowJson = <String, Object?>{};
  
  @override
  Map<String, Object?> get getRowJson => _rowJson;
    
      int? get get_id => _rowJson['id'] as int?;
            int? get get_aiid => _rowJson['aiid'] as int?;
            String? get get_uuid => _rowJson['uuid'] as String?;
            int? get get_created_at => _rowJson['created_at'] as int?;
            int? get get_updated_at => _rowJson['updated_at'] as int?;
      
  User createModel({
          required int? id,
                required int? aiid,
                required String? uuid,
                required int? created_at,
                required int? updated_at,
        
  }) {
    _rowJson.addAll(
      <String, Object?>{
                'id': id,
              'aiid': aiid,
              'uuid': uuid,
              'created_at': created_at,
              'updated_at': updated_at,
      
      },
    );
    return this;
  }
  
    Set<String> getDeleteManyForTwo() => <String>{
              'user_info.user',
        
    };    
    
    Set<String> getDeleteManyForSingle() => <String>{
      
    };    
    
}
