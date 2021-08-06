import 'package:demo/data/model/ModelBase.dart';
import 'package:demo/data/sqlite/sqliter/SqliteCurd.dart';
import 'package:demo/muc/getcontroller/homepage/PoolGetController.dart';
import 'package:demo/muc/view/homepage/poolentry/AbstractPoolEntry.dart';
import 'package:demo/util/SbHelper.dart';
import 'package:demo/util/sbbutton/Global.dart';
import 'package:demo/util/sblogger/SbLogger.dart';
import 'package:demo/util/sbroundedbox/SbRoundedBox.dart';
import 'package:demo/util/sbroute/AutoPosition.dart';
import 'package:demo/util/sbroute/SbPopResult.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class LongPressedNodeRouteBase extends AbstractPoolEntryRoute {
  LongPressedNodeRouteBase(PoolNodeModel poolNodeModel) : super(poolNodeModel);

  @override
  List<Widget> body() {
    return <Widget>[
      AutoPositioned(
        touchPosition: touchPosition,
        child: SbRoundedBox(
          children: <Widget>[
            TextButton(
              child: const Text('删除节点'),
              onPressed: () async {
                SbHelper().getNavigator!.pop(SbPopResult(popResultSelect: PopResultSelect.one, value: null));
              },
            ),
          ],
        ),
      ),
    ];
  }

  @override
  bool whenException(Object exception, StackTrace stackTrace) {
    sbLogger(message: 'err: ', exception: exception, stackTrace: stackTrace);
    return false;
  }

  @override
  Future<bool> whenPop(SbPopResult? popResult) async {
    return await quickWhenPop(popResult, (SbPopResult quickPopResult) async {
      if (quickPopResult.popResultSelect == PopResultSelect.one) {
        await SqliteCurd<ModelBase>().deleteRow(
          modelTableName: poolNodeModel.getCurrentNodeModel().tableName,
          modelId: poolNodeModel.getCurrentNodeModel().get_id,
          transactionMark: null,
        );
        Get.find<PoolGetController>().updateLogic.deleteNode(poolNodeModel);
        return true;
      }
      return false;
    });
  }
}

class LongPressedNodeRouteForFragment extends LongPressedNodeRouteBase {
  LongPressedNodeRouteForFragment(PoolNodeModel poolNodeModel) : super(poolNodeModel);
}

class LongPressedNodeRouteForMemory extends LongPressedNodeRouteBase {
  LongPressedNodeRouteForMemory(PoolNodeModel poolNodeModel) : super(poolNodeModel);
}

class LongPressedNodeRouteForComplete extends LongPressedNodeRouteBase {
  LongPressedNodeRouteForComplete(PoolNodeModel poolNodeModel) : super(poolNodeModel);
}

class LongPressedNodeRouteForRule extends LongPressedNodeRouteBase {
  LongPressedNodeRouteForRule(PoolNodeModel poolNodeModel) : super(poolNodeModel);
}
