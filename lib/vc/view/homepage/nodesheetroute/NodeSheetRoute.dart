import 'package:demo/util/sheetroute/SbSheetRoute.dart';
import 'package:demo/util/sheetroute/SbSheetRouteController.dart';
import 'package:flutter/cupertino.dart';

class NodeSheetRoute extends SbSheetRoute<dynamic, dynamic> {
  @override
  Widget bodySliver() {
    return const SliverToBoxAdapter(
      child: Text('body'),
    );
  }

  @override
  Future<BodyDataFutureResult> bodyDataFuture(List bodyData, Mark mark) async {
    await Future<void>.delayed(Duration(seconds: 2));
    return BodyDataFutureResult.success;
  }

  @override
  Widget headerSliver() {
    return const SliverToBoxAdapter(
      child: Text('header'),
    );
  }

  @override
  void popMethod() {
    navigator!.removeRoute(this);
  }
}
