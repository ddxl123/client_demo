import 'package:demo/util/sheetroute/SbSheetRoute.dart';
import 'package:demo/util/sheetroute/SbSheetRouteController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class NodeSheetRouteBase<T, M> extends SbSheetRoute<T, M> {
  @override
  Widget bodySliver();

  @override
  Future<void> bodyDataFuture(List<T> bodyData, Mark<M> mark);

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
}
