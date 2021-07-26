import 'package:demo/data/sqlite/modelbuilder/builder/Type.dart';
import 'package:demo/data/sqlite/modelbuilder/builder/creator/FieldCreator.dart';
import 'package:demo/data/sqlite/modelbuilder/builder/creator/ForeignKeyCreator.dart';
import 'package:demo/data/sqlite/modelbuilder/builder/creator/ModelCreator.dart';
import 'package:demo/data/sqlite/modelbuilder/model/f/MFRule.dart';

class MPnFragment extends ModelCreator {
  @override
  // TODO: implement fields
  List<FieldCreator> get fields => <FieldCreator>[
        ForeignKeyAiidField(fieldName: 'used_rule_aiid', foreignKey: ForeignKeyCreator(MFRule(), true)),
        NormalField(fieldName: 'easy_position', sqliteTypes: <String>[SqliteType.TEXT], dartType: DartType.STRING),
        NormalField(fieldName: 'title', sqliteTypes: <String>[SqliteType.TEXT], dartType: DartType.STRING),
      ];
}
