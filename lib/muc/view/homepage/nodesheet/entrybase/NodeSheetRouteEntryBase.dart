import 'package:demo/data/model/ModelBase.dart';
import 'package:demo/muc/view/homepage/poolentry/PoolEntryBase.dart';
import 'package:demo/util/SbHelper.dart';
import 'package:demo/util/sheetroute/SbSheetRoute.dart';
import 'package:demo/util/sheetroute/SbSheetRouteController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class NodeSheetRouteEntryBase<PNM extends ModelBase, D> extends SheetRoutePoolEntryBase<PNM, D> {
  NodeSheetRouteEntryBase(PNM poolNodeModel) : super(poolNodeModel);

  @override
  Widget bodySliver() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        bodyBuilder,
        childCount: sheetPageController.bodyData.length,
      ),
    );
  }

  @override
  Future<void> bodyDataFuture(List<D> bodyData, Mark mark);

  @override
  Widget headerSliver() {
    return SliverToBoxAdapter(
      child: Container(
        child: Row(
          children: <Widget>[
            Text(nodeVo.getTitle()),
            Expanded(child: Container()),
            TextButton(
              child: const Icon(Icons.more_horiz),
              onPressed: () {
                SbHelper().getNavigator!.push(moreRoute);
              },
            ),
          ],
        ),
        color: Colors.white,
      ),
    );
  }

  @override
  void popMethod() {
    SbHelper().getNavigator!.removeRoute(this);
  }

  @override
  Widget failureWidget() {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Text('获取失败！'),
      ),
    );
  }

  @override
  Widget loadingWidget() {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Text('获取中...'),
      ),
    );
  }

  @override
  Widget noMoreWidget() {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Text('没有更多了~'),
      ),
    );
  }

  /// 点右上角更多的按钮要触发的 route
  MoreRouteBase get moreRoute;

  Widget? bodyBuilder(BuildContext context, int index);
}
