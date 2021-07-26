import 'package:demo/data/model/PnFragment.dart';
import 'package:demo/data/sqlite/sqliter/OpenSqlite.dart';
import 'package:demo/util/SbHelper.dart';
import 'package:demo/util/sblogger/SbLogger.dart';

class SqliteTest {
  Future<void> createTestData() async {
    const int count = 100;
    for (int i = 0; i < count; i++) {
      final PnFragment pnFragment = PnFragment()
        ..createModel(
          id: null,
          aiid: null,
          uuid: null,
          created_at: null,
          updated_at: null,
          used_rule_aiid: null,
          easy_position: '${SbHelper().randomDouble(2000)},${SbHelper().randomDouble(2000)}',
          title: SbHelper().randomString(20),
        );
      await db.insert(pnFragment.tableName, pnFragment.getRowJson);
    }
    sbLogger(message: '生成测试数据成功！');
  }
}
