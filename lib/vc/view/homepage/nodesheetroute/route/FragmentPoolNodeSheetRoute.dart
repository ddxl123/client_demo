import 'package:demo/data/model/MFFragment.dart';
import 'package:demo/data/model/ModelManager.dart';
import 'package:demo/util/sheetroute/SbSheetRouteController.dart';
import 'package:demo/vc/view/homepage/nodesheetroute/NodeSheetRouteBase.dart';
import 'package:flutter/material.dart';

class FragmentPoolNodeSheetRoute extends NodeSheetRouteBase<MFFragment, int> {
  @override
  Future<void> bodyDataFuture(List<MFFragment> bodyData, Mark<int> mark) async {
    const int limit = 10;
    mark.value ??= 0;

    final MFFragment model = MFFragment();
    final List<MFFragment> models = await ModelManager.queryRowsAsModels(connectTransaction: null, tableName: model.tableName, limit: limit, offset: mark.value);
    bodyData.addAll(models);

    mark.value = mark.value! + limit;
  }

  @override
  Widget bodySliver() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, int index) {
          return Text(sheetPageController.bodyData[index].get_title ?? '');
        },
        childCount: sheetPageController.bodyData.length,
      ),
    );
  }
}