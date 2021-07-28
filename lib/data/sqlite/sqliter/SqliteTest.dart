// ignore_for_file: non_constant_identifier_names
import 'package:demo/data/model/MFComplete.dart';
import 'package:demo/data/model/MFFragment.dart';
import 'package:demo/data/model/MFMemory.dart';
import 'package:demo/data/model/MFRule.dart';
import 'package:demo/data/model/MPnComplete.dart';
import 'package:demo/data/model/MPnFragment.dart';
import 'package:demo/data/model/MPnMemory.dart';
import 'package:demo/data/model/MPnRule.dart';
import 'package:demo/util/SbHelper.dart';
import 'package:demo/util/sblogger/SbLogger.dart';

class SqliteTest {
  Future<void> _for({required int count, required Future<void> Function() insert}) async {
    for (int i = 0; i < count; i++) {
      await insert();
    }
  }

  Future<void> createTestData() async {
    //
    await _for(
      count: 100,
      insert: () async {
        await MPnFragment.createModel(
          id: null,
          aiid: null,
          uuid: null,
          created_at: null,
          updated_at: null,
          used_rule_aiid: null,
          easy_position: '${SbHelper().randomDouble(2000)},${SbHelper().randomDouble(2000)}',
          title: SbHelper().randomString(20),
        ).insertDb();
      },
    );
    await _for(
      count: 100,
      insert: () async {
        await MPnMemory.createModel(
          id: null,
          aiid: null,
          uuid: null,
          created_at: null,
          updated_at: null,
          easy_position: '${SbHelper().randomDouble(2000)},${SbHelper().randomDouble(2000)}',
          title: SbHelper().randomString(20),
        ).insertDb();
      },
    );
    await _for(
      count: 100,
      insert: () async {
        await MPnComplete.createModel(
          id: null,
          aiid: null,
          uuid: null,
          created_at: null,
          updated_at: null,
          easy_position: '${SbHelper().randomDouble(2000)},${SbHelper().randomDouble(2000)}',
          title: SbHelper().randomString(20),
        ).insertDb();
      },
    );
    await _for(
      count: 100,
      insert: () async {
        await MPnRule.createModel(
          id: null,
          aiid: null,
          uuid: null,
          created_at: null,
          updated_at: null,
          easy_position: '${SbHelper().randomDouble(2000)},${SbHelper().randomDouble(2000)}',
          title: SbHelper().randomString(20),
        ).insertDb();
      },
    );

    await _for(
      count: 100,
      insert: () async {
        await MFFragment.createModel(id: null, aiid: null, uuid: null, created_at: null, updated_at: null, title: SbHelper().randomString(10)).insertDb();
      },
    );

    await _for(
      count: 100,
      insert: () async {
        await MFMemory.createModel(id: null, aiid: null, uuid: null, created_at: null, updated_at: null, title: SbHelper().randomString(10)).insertDb();
      },
    );

    await _for(
      count: 100,
      insert: () async {
        await MFComplete.createModel(id: null, aiid: null, uuid: null, created_at: null, updated_at: null, title: SbHelper().randomString(10)).insertDb();
      },
    );

    await _for(
      count: 100,
      insert: () async {
        await MFRule.createModel(id: null, aiid: null, uuid: null, created_at: null, updated_at: null, title: SbHelper().randomString(10)).insertDb();
      },
    );
    //
    sbLogger(message: '生成测试数据成功！');
  }
}
