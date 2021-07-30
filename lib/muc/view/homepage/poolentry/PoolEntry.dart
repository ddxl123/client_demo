import 'package:demo/data/vo/PoolNodeModel.dart';
import 'package:demo/muc/view/homepage/nodesheet/route/FragmentPoolNodeSheetRoute.dart';
import 'package:demo/util/SbHelper.dart';
import 'package:demo/muc/getcontroller/homepage/PoolGetController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PoolEntry {
  PoolEntry.forNodeSheetRoute(PoolNodeModel vo) {
    fragmentPoolGetController.select(
      fragmentPoolType: fragmentPoolGetController.currentPoolType,
      fragmentPoolCallback: () => to(FragmentPoolNodeSheetRoute()..setCurrentNodeVo = vo),
      memoryPoolCallback: () => to(MemoryPoolNodeSheetRoute()..setCurrentNodeVo = vo),
      completePoolCallback: () => to(CompletePoolNodeSheetRoute()..setCurrentNodeVo = vo),
      rulePoolCallback: () => to(RulePoolNodeSheetRoute()..setCurrentNodeVo = vo),
    );
  }

  PoolEntry.forLongPressNodeRoute(PoolNodeModel vo) {
    fragmentPoolGetController.select(
      fragmentPoolType: fragmentPoolGetController.currentPoolType,
      fragmentPoolCallback: () => to(LongPressNodeForFragmentPoolRoute()..setCurrentNodeVo = vo),
      memoryPoolCallback: () => to(LongPressNodeForMemoryPoolRoute()..setCurrentNodeVo = vo),
      completePoolCallback: () => to(LongPressNodeForCompletePoolRoute()..setCurrentNodeVo = vo),
      rulePoolCallback: () => to(LongPressNodeForRulePoolRoute()..setCurrentNodeVo = vo),
    );
  }

  final PoolGetController fragmentPoolGetController = Get.find<PoolGetController>();

  void to(Route<void> route) {
    SbHelper().getNavigator!.push<void>(route);
  }
}
