import 'package:demo/vc/getcontroller/homepage/FragmentPoolGetController.dart';
import 'package:demo/vc/view/homepage/nodesheetroute/route/CompletePoolNodeSheetRoute.dart';
import 'package:demo/vc/view/homepage/nodesheetroute/route/FragmentPoolNodeSheetRoute.dart';
import 'package:demo/vc/view/homepage/nodesheetroute/route/MemoryPoolNodeSheetRoute.dart';
import 'package:demo/vc/view/homepage/nodesheetroute/route/RulePoolNodeSheetRoute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NodeSheetRouteEntry {
  NodeSheetRouteEntry.enter() {
    final FragmentPoolGetController fragmentPoolGetController = Get.find<FragmentPoolGetController>();

    void to(Route<void> route) {
      navigator!.push<void>(route);
    }

    fragmentPoolGetController.select(
      fragmentPoolType: fragmentPoolGetController.currentPoolType,
      fragmentPoolCallback: () {
        to(FragmentPoolNodeSheetRoute());
      },
      memoryPoolCallback: () {
        to(MemoryPoolNodeSheetRoute());
      },
      completePoolCallback: () {
        to(CompletePoolNodeSheetRoute());
      },
      rulePoolCallback: () {
        to(RulePoolNodeSheetRoute());
      },
    );
  }
}
