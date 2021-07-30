import 'package:demo/data/sqlite/modelbuilder/builder/Type.dart';
import 'package:demo/data/sqlite/modelbuilder/builder/creator/FieldCreator.dart';
import 'package:demo/data/sqlite/modelbuilder/builder/creator/ForeignKeyCreator.dart';
import 'package:demo/data/sqlite/modelbuilder/builder/creator/ModelCreator.dart';
import 'package:demo/data/sqlite/modelbuilder/model/pn/CPnMemory.dart';

class CFMemory extends ModelCreator {
  @override
  List<FieldCreator> get fields => <FieldCreator>[
        NormalField(fieldName: 'title', sqliteTypes: <String>[SqliteType.TEXT], dartType: DartType.STRING),
        ForeignKeyAiidField(fieldName: 'node_aiid', foreignKey: ForeignKeyCreator(CPnMemory(), true)),
        ForeignKeyUuidField(fieldName: 'node_uuid', foreignKey: ForeignKeyCreator(CPnMemory(), true)),
      ];
}
