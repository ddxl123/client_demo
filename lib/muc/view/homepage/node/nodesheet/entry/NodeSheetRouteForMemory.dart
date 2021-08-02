import 'package:demo/data/model/MFMemory.dart';
import 'package:demo/data/model/MPnMemory.dart';
import 'package:demo/data/model/ModelManager.dart';
import 'package:demo/muc/getcontroller/homepage/PoolGetController.dart';
import 'package:demo/muc/view/homepage/node/nodesheet/longpressedfragment/LongPressedFragment.dart';
import 'package:demo/muc/view/homepage/node/nodesheet/more/AbstractMoreRoute.dart';
import 'package:demo/muc/view/homepage/node/nodesheet/more/MoreRoute.dart';
import 'package:demo/util/SbHelper.dart';
import 'package:demo/util/sbbutton/SbButton.dart';
import 'package:demo/util/sheetroute/SbSheetRouteController.dart';
import 'package:flutter/material.dart';

import 'AbstractNodeSheetRoute.dart';

class NodeSheetRouteForMemory extends AbstractNodeSheetRoute<MFMemory> {
  NodeSheetRouteForMemory(PoolNodeModel poolNodeModel) : super(poolNodeModel);

  @override
  Future<void> bodyDataFuture(List<MFMemory> bodyData, Mark mark) async {
    const int limit = 10;

    final MFMemory forKey = MFMemory();
    final List<MFMemory> models = await ModelManager.queryRowsAsModels(
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

    if (models.isNotEmpty) {
      mark.value = models.last.get_id!;
    }
  }

  @override
  Widget? bodyBuilder(BuildContext context, int index) => Container(
        color: Colors.white,
        child: SbButton(
          child: Text(sheetPageController.bodyData[index].get_title ?? ''),
          onLongPressed: (PointerDownEvent event) {
            SbHelper().getNavigator!.push(LongPressedFragmentForMemory(poolNodeModel, sheetPageController.bodyData[index]));
          },
        ),
      );

  @override
  String get nodeTitle => poolNodeModel.getCurrentNodeModel<MPnMemory>().get_title ?? 'unknown';

  @override
  AbstractMoreRoute get moreRoute => MoreRouteForMemory(poolNodeModel);
}
