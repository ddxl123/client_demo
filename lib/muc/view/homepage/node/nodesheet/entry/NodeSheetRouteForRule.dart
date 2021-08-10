import 'package:demo/data/model/MFRule.dart';
import 'package:demo/data/model/MPnRule.dart';
import 'package:demo/data/model/ModelManager.dart';
import 'package:demo/muc/getcontroller/homepage/PoolGetController.dart';
import 'package:demo/muc/view/homepage/node/nodesheet/longpressedfragment/LongPressedFragment.dart';
import 'package:demo/muc/view/homepage/node/nodesheet/more/AbstractMoreRoute.dart';
import 'package:demo/muc/view/homepage/node/nodesheet/more/MoreRoute.dart';
import 'package:demo/util/SbHelper.dart';
import 'package:demo/util/sbbutton/SbButton.dart';
import 'package:demo/util/sblogger/SbLogger.dart';
import 'package:demo/util/sheetroute/SbSheetRouteController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AbstractNodeSheetRoute.dart';

class NodeSheetRouteForRule extends AbstractNodeSheetRoute<MFRule> {
  NodeSheetRouteForRule(PoolNodeModel poolNodeModel) : super(poolNodeModel);

  @override
  Future<void> bodyDataFuture(List<MFRule> bodyData, Mark mark) async {
    const int limit = 10;

    if (bodyData.isNotEmpty) {
      mark.value = bodyData.last.get_id!;
    } else {
      mark.value = 0;
    }
    final MFRule forKey = MFRule();
    final List<MFRule> models = await ModelManager.queryRowsAsModels(
      connectTransaction: null,
      tableName: forKey.tableName,
      limit: limit,
      offset: mark.value,
      byTwoId: TwoId(
        uuidKey: forKey.node_uuid,
        aiidKey: forKey.node_aiid,
        uuidValue: poolNodeModel.getCurrentNodeModel().get_uuid,
        aiidValue: poolNodeModel.getCurrentNodeModel().get_aiid,
      ),
    );
    bodyData.addAll(models);
  }

  @override
  void bodyDataException(Object? exception, StackTrace? stackTrace) {
    SbLogger(
      code: null,
      viewMessage: null,
      data: null,
      description: null,
      exception: exception,
      stackTrace: stackTrace,
    );
  }

  @override
  Widget? bodyBuilder(BuildContext context, int index) => Container(
        color: Colors.white,
        child: SbButton(
          child: Text(sheetPageController.bodyData[index].get_title ?? ''),
          onLongPressed: (PointerDownEvent event) {
            SbHelper().getNavigator!.push(LongPressedFragmentForRule(this, sheetPageController.bodyData[index]));
          },
        ),
      );

  @override
  String get nodeTitle => poolNodeModel.getCurrentNodeModel<MPnRule>().get_title ?? 'unknown';

  @override
  AbstractMoreRoute<MFRule> get moreRoute => MoreRouteForRule(this);
}
