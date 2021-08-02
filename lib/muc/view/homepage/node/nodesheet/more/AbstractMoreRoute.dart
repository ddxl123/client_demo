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

abstract class AbstractMoreRoute extends AbstractPoolEntryRoute {
  AbstractMoreRoute(PoolNodeModel poolNodeModel) : super(poolNodeModel);

  @override
  List<Widget> body() {
    return <Widget>[
      AutoPositioned(
        child: SbRoundedBox(
          children: <Widget>[
            TextButton(
              child: const Text('添加碎片'),
              onPressed: () {
                SbHelper().getNavigator!.pop(SbPopResult(popResultSelect: PopResultSelect.one, value: null));
              },
            ),
          ],
        ),
        touchPosition: touchPosition,
      ),
    ];
  }

  @override
  bool whenException(Object exception, StackTrace stackTrace) {
    sbLogger(message: 'err: ', exception: exception, stackTrace: stackTrace);
    return true;
  }

  @override
  Future<bool> whenPop(SbPopResult? popResult) async {
    return await quickWhenPop(
      popResult,
      (SbPopResult quickPopResult) async {
        if (quickPopResult.popResultSelect == PopResultSelect.one) {
          await SqliteCurd<ModelBase>().insertRow(model: newModel, transactionMark: null);
          return true;
        }
        return false;
      },
    );
  }

  /// 创建新碎片需要的模型。
  ModelBase get newModel;
}
