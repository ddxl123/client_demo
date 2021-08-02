import 'package:demo/data/model/MFComplete.dart';
import 'package:demo/data/model/MPnComplete.dart';
import 'package:demo/data/model/ModelManager.dart';
import 'package:demo/muc/getcontroller/homepage/PoolGetController.dart';
import 'package:demo/muc/view/homepage/node/nodesheet/entry/AbstractNodeSheetRoute.dart';
import 'package:demo/muc/view/homepage/node/nodesheet/longpressedfragment/LongPressedFragment.dart';
import 'package:demo/muc/view/homepage/node/nodesheet/more/AbstractMoreRoute.dart';
import 'package:demo/muc/view/homepage/node/nodesheet/more/MoreRoute.dart';
import 'package:demo/util/SbHelper.dart';
import 'package:demo/util/sbbutton/SbButton.dart';
import 'package:demo/util/sheetroute/SbSheetRouteController.dart';
import 'package:flutter/material.dart';

class NodeSheetRouteForComplete extends AbstractNodeSheetRoute<MFComplete> {
  NodeSheetRouteForComplete(PoolNodeModel poolNodeModel) : super(poolNodeModel);

  @override
  Future<void> bodyDataFuture(List<MFComplete> bodyData, Mark mark) async {
    const int limit = 10;

    final MFComplete forKey = MFComplete();
    final List<MFComplete> models = await ModelManager.queryRowsAsModels(
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
          onUp: (PointerUpEvent event) {},
          onLongPressed: (PointerDownEvent event) {
            SbHelper().getNavigator!.push(LongPressedFragmentForComplete(poolNodeModel, sheetPageController.bodyData[index]));
          },
        ),
      );

  @override
  String get nodeTitle => poolNodeModel.getCurrentNodeModel<MPnComplete>().get_title ?? 'unknown';

  @override
  AbstractMoreRoute get moreRoute => MoreRouteForComplete(poolNodeModel);
}
