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

abstract class AbstractLongPressedFragment<FDM extends ModelBase> extends AbstractPoolEntryRoute {
  AbstractLongPressedFragment(this.fatherRoute, this.currentFragmentModel) : super(fatherRoute.poolNodeModel);

  final AbstractNodeSheetRoute<FDM> fatherRoute;

  final FDM currentFragmentModel;

  @override
  List<Widget> body() {
    return <Widget>[
      AutoPositioned(
        child: SbRoundedBox(children: <Widget>[
          TextButton(
            child: const Text('删除碎片'),
            onPressed: () {
              SbHelper().getNavigator!.pop(SbPopResult(popResultSelect: PopResultSelect.one, value: null));
            },
          ),
        ]),
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
      description: 'pop err',
      exception: exception,
      stackTrace: stackTrace,
    );
    return false;
  }

  @override
  Future<bool> whenPop(SbPopResult? popResult) async {
    return await quickWhenPop(
      popResult,
      (SbPopResult quickPopResult) async {
        if (quickPopResult.popResultSelect == PopResultSelect.one) {
          await SqliteCurd<FDM>().deleteRow(
            modelTableName: currentFragmentModel.tableName,
            modelId: currentFragmentModel.get_id,
            transactionMark: null,
          );
          fatherRoute.sheetPageController.bodyData.remove(currentFragmentModel);
          return true;
        }
        return false;
      },
    );
  }
}
