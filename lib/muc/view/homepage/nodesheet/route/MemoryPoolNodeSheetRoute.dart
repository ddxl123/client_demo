import 'package:demo/data/model/MFMemory.dart';
import 'package:demo/data/model/MPnMemory.dart';
import 'package:demo/data/model/ModelBase.dart';
import 'package:demo/data/model/ModelManager.dart';
import 'package:demo/muc/view/homepage/nodesheet/entrybase/NodeSheetRouteEntryBase.dart';
import 'package:demo/util/SbHelper.dart';
import 'package:demo/util/sbbutton/SbButton.dart';
import 'package:demo/util/sheetroute/SbSheetRouteController.dart';
import 'package:flutter/material.dart';

class MemoryPoolNodeSheetRoute extends NodeSheetRouteEntryBase<MPnMemory, MFMemory> {
  MemoryPoolNodeSheetRoute(MPnMemory poolNodeModel) : super(poolNodeModel);

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
        uuidValue: getCurrentNodeVo.currentNodeModel.get_uuid,
        aiidValue: getCurrentNodeVo.currentNodeModel.get_aiid,
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
            SbHelper().getNavigator!.push(_LongPressFragment(sheetPageController.bodyData[index]));
          },
        ),
      );

  @override
  MoreRouteBase get moreRoute => _MoreRoute(this);
}

class _MoreRoute extends MoreRouteBase {
  _MoreRoute(this.currentSheetRoute);

  final MemoryPoolNodeSheetRoute currentSheetRoute;

  @override
  ModelBase get newModel => MFMemory.createModel(
        id: null,
        aiid: null,
        uuid: SbHelper().newUuid,
        created_at: SbHelper().newTimestamp,
        updated_at: SbHelper().newTimestamp,
        title: SbHelper().randomString(10),
        node_aiid: currentSheetRoute.getCurrentNodeVo.currentNodeModel.get_aiid,
        node_uuid: currentSheetRoute.getCurrentNodeVo.currentNodeModel.get_uuid,
      );
}

class _LongPressFragment extends LongPressFragmentBase {
  _LongPressFragment(ModelBase currentFragmentModel) : super(currentFragmentModel);
}
