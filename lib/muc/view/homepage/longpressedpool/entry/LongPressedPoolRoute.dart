import 'package:demo/data/model/MPnComplete.dart';
import 'package:demo/data/model/MPnFragment.dart';
import 'package:demo/data/model/MPnMemory.dart';
import 'package:demo/data/model/MPnRule.dart';
import 'package:demo/data/sqlite/sqliter/SqliteCurd.dart';
import 'package:demo/muc/getcontroller/homepage/PoolGetController.dart';
import 'package:demo/util/SbHelper.dart';

import 'AbstractLongPressedPoolRoute.dart';

class LongPressedPoolRouteForFragment extends AbstractLongPressedPoolRoute {
  @override
  Future<PoolNodeModel> createNewNode(String easyPosition) async {
    final MPnFragment pnFragment = MPnFragment.createModel(
      id: null,
      aiid: null,
      uuid: SbHelper().newUuid,
      created_at: null,
      updated_at: null,
      used_rule_aiid: null,
      easy_position: easyPosition,
      title: SbHelper().randomString(10),
    );
    final MPnFragment newModel = await SqliteCurd<MPnFragment>().insertRow(model: pnFragment, transactionMark: null);
    return PoolNodeModel.from(newModel);
  }
}

class LongPressedPoolRouteForMemory extends AbstractLongPressedPoolRoute {
  @override
  Future<PoolNodeModel> createNewNode(String easyPosition) async {
    final MPnMemory pnMemory = MPnMemory.createModel(
      id: null,
      aiid: null,
      uuid: SbHelper().newUuid,
      created_at: null,
      updated_at: null,
      easy_position: easyPosition,
      title: SbHelper().randomString(10),
    );
    final MPnMemory newModel = await SqliteCurd<MPnMemory>().insertRow(model: pnMemory, transactionMark: null);
    return PoolNodeModel.from(newModel);
  }
}

class LongPressedPoolRouteForComplete extends AbstractLongPressedPoolRoute {
  @override
  Future<PoolNodeModel> createNewNode(String easyPosition) async {
    final MPnComplete pnComplete = MPnComplete.createModel(
      id: null,
      aiid: null,
      uuid: SbHelper().newUuid,
      created_at: null,
      updated_at: null,
      easy_position: easyPosition,
      title: SbHelper().randomString(10),
    );
    final MPnComplete newModel = await SqliteCurd<MPnComplete>().insertRow(model: pnComplete, transactionMark: null);
    return PoolNodeModel.from(newModel);
  }
}

class LongPressedPoolRouteForRule extends AbstractLongPressedPoolRoute {
  @override
  Future<PoolNodeModel> createNewNode(String easyPosition) async {
    final MPnRule pnRule = MPnRule.createModel(
      id: null,
      aiid: null,
      uuid: SbHelper().newUuid,
      created_at: null,
      updated_at: null,
      easy_position: easyPosition,
      title: SbHelper().randomString(10),
    );
    final MPnRule newModel = await SqliteCurd<MPnRule>().insertRow(model: pnRule, transactionMark: null);
    return PoolNodeModel.from(newModel);
  }
}
