import 'package:demo/data/sqlite/mmodel/ModelBase.dart';
import 'package:demo/data/sqlite/sqliter/SqliteCurd.dart';
import 'package:demo/muc/view/homepage/node/nodesheet/entry/AbstractNodeSheetRoute.dart';
import 'package:demo/muc/view/homepage/poolentry/AbstractPoolEntry.dart';
import 'package:demo/util/SbHelper.dart';
import 'package:demo/util/sbbutton/Global.dart';
import 'package:demo/util/sblogger/SbLogger.dart';
import 'package:demo/util/sbroundedbox/SbRoundedBox.dart';
import 'package:demo/util/sbroute/AutoPosition.dart';
import 'package:demo/util/sbroute/SbPopResult.dart';
import 'package:flutter/material.dart';

abstract class AbstractMoreRoute<FDM extends ModelBase> extends AbstractPoolEntryRoute {
  AbstractMoreRoute(this.fatherRoute) : super(fatherRoute.poolNodeModel);

  late final AbstractNodeSheetRoute<FDM> fatherRoute;

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
  bool whenException(Object? exception, StackTrace? stackTrace) {
    SbLogger(
      code: null,
      viewMessage: null,
      data: null,
      description: null,
      exception: exception,
      stackTrace: stackTrace,
    );
    return true;
  }

  @override
  Future<bool> whenPop(SbPopResult? popResult) async {
    return await quickWhenPop(
      popResult,
      (SbPopResult quickPopResult) async {
        if (quickPopResult.popResultSelect == PopResultSelect.one) {
          final FDM newModel = await SqliteCurd<FDM>().insertRow(model: insertModel, transactionMark: null);
          fatherRoute.sheetPageController.bodyData.add(newModel);
          return true;
        }
        return false;
      },
    );
  }

  /// 创建新碎片需要的模型。
  FDM get insertModel;
}
