import 'package:demo/database/modelbuilder/builder/creator/FieldCreator.dart';
import 'package:demo/database/modelbuilder/builder/creator/ModelCreator.dart';

class UserModel extends ModelCreator {
  @override
  List<FieldCreator> get fields {
    return <FieldCreator>[];
  }

  @override
  String get currentTableName => 'user';
}
