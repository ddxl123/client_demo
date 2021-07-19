import 'package:demo/database/modelbuilder/builder/creator/FieldCreator.dart';
import 'package:demo/database/modelbuilder/builder/creator/ForeignKeyCreator.dart';
import 'package:demo/database/modelbuilder/builder/creator/ModelCreator.dart';

class UserInfoModel extends ModelCreator {
  @override
  List<FieldCreator> get fields {
    return <FieldCreator>[
      ForeignKeyAiidField(
        fieldName: 'user_aiid',
        foreignKey: ForeignKeyCreator('user', true),
      ),
    ];
  }

  @override
  String get currentTableName => 'user_info';
}
