import 'package:demo/data/model/ModelBase.dart';
import 'package:demo/data/sqlite/sqliter/SqliteCurd.dart';
import 'package:demo/muc/getcontroller/homepage/PoolGetController.dart';
import 'package:demo/muc/view/homepage/poolentry/PoolEntryBase.dart';
import 'package:demo/util/sbbutton/Global.dart';
import 'package:demo/util/sblogger/SbLogger.dart';
import 'package:demo/util/sbroundedbox/SbRoundedBox.dart';
import 'package:demo/util/sbroute/AutoPosition.dart';
import 'package:demo/util/sbroute/SbPopResult.dart';
import 'package:demo/util/sbroute/SbRoute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class LongPressNodeRouteEntryBase<PNM extends ModelBase> extends RoutePoolEntryBase<PNM> {
  LongPressNodeRouteEntryBase(PNM poolNodeModel) : super(poolNodeModel);

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
                await SqliteCurd<ModelBase>().deleteRow(
                  modelTableName: getCurrentNodeVo.currentNodeModel.tableName,
                  modelId: getCurrentNodeVo.currentNodeModel.get_id,
                  transactionMark: null,
                );
                sbLogger(message: '1--', indent: Get.find<PoolGetController>().currentPoolData);
                Get.find<PoolGetController>().currentPoolData.remove(getCurrentNodeVo);
                sbLogger(message: '1--', indent: Get.find<PoolGetController>().currentPoolData);
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
    return await quickWhenPop(popResult, (SbPopResult quickPopResult) async => false);
  }
}
