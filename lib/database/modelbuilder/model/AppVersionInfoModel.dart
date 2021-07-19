import 'package:demo/database/modelbuilder/builder/Type.dart';
import 'package:demo/database/modelbuilder/builder/creator/FieldCreator.dart';
import 'package:demo/database/modelbuilder/builder/creator/ModelCreator.dart';

class AppVersionInfoModel extends ModelCreator {
  @override
  String get currentTableName => 'app_version_info';

  @override
  List<FieldCreator> get fields {
    return <FieldCreator>[
      NormalField(
        fieldName: 'saved_version',
        sqliteTypes: <String>[SqliteType.TEXT],
        dartType: DartType.STRING,
      ),
    ];
  }
}
