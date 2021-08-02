import 'package:demo/muc/getcontroller/homepage/PoolGetController.dart';
import 'package:demo/muc/view/homepage/longpressedpool/entry/AbstractLongPressedPoolRoute.dart';
import 'package:demo/muc/view/homepage/longpressedpool/entry/LongPressedPoolRoute.dart';
import 'package:demo/muc/view/homepage/node/entry/NodeWidget.dart';
import 'package:demo/util/SbHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PoolEntry {
  Widget toNode(PoolNodeModel poolNodeModel) {
    return fragmentPoolGetController.select<Widget>(
      fragmentPoolType: fragmentPoolGetController.currentPoolType,
      fragmentPoolCallback: () => NodeWidgetForFragment(poolNodeModel),
      memoryPoolCallback: () => NodeWidgetForMemory(poolNodeModel),
      completePoolCallback: () => NodeWidgetForComplete(poolNodeModel),
      rulePoolCallback: () => NodeWidgetForRule(poolNodeModel),
    )!;
  }

  AbstractLongPressedPoolRoute toLongPressPool() {
    return fragmentPoolGetController.select<AbstractLongPressedPoolRoute>(
      fragmentPoolType: fragmentPoolGetController.currentPoolType,
      fragmentPoolCallback: () => LongPressedPoolRouteForFragment(),
      memoryPoolCallback: () => LongPressedPoolRouteForMemory(),
      completePoolCallback: () => LongPressedPoolRouteForComplete(),
      rulePoolCallback: () => LongPressedPoolRouteForRule(),
    )!;
  }

  final PoolGetController fragmentPoolGetController = Get.find<PoolGetController>();

  void to(Route<void> route) {
    SbHelper().getNavigator!.push<void>(route);
  }
}
