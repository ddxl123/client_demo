import 'package:demo/global/Global.dart';
import 'package:demo/muc/getcontroller/homepage/PoolGetController.dart';
import 'package:demo/util/sblogger/SbLogger.dart';
import 'package:demo/util/sbroundedbox/SbRoundedBox.dart';
import 'package:demo/util/sbroute/SbPopResult.dart';
import 'package:demo/util/sbroute/SbRoute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectPoolRoute extends SbRoute {
  SelectPoolRoute({required Rect triggerRect}) : super(triggerRect: triggerRect);

  @override
  List<Widget> body() {
    return <Widget>[
      Positioned(
        bottom: screenSize.height - triggerRect!.top,
        right: 0,
        left: 0,
        child: SbRoundedBox(
          children: <Widget>[
            TextButton(
              child: const Text('碎片池'),
              onPressed: () {
                Get.back<SbPopResult>(result: SbPopResult(popResultSelect: PopResultSelect.one, value: PoolType.fragment));
              },
            ),
            TextButton(
              child: const Text('记忆池'),
              onPressed: () {
                Get.back<SbPopResult>(result: SbPopResult(popResultSelect: PopResultSelect.one, value: PoolType.memory));
              },
            ),
            TextButton(
              child: const Text('完成池'),
              onPressed: () {
                Get.back<SbPopResult>(result: SbPopResult(popResultSelect: PopResultSelect.one, value: PoolType.complete));
              },
            ),
            TextButton(
              child: const Text('规则池'),
              onPressed: () {
                Get.back<SbPopResult>(result: SbPopResult(popResultSelect: PopResultSelect.one, value: PoolType.rule));
              },
            ),
          ],
        ),
      ),
    ];
  }

  @override
  Future<bool> whenPop(SbPopResult? popResult) async {
    return await quickWhenPop(
      popResult,
      (SbPopResult quickPopResult) async {
        if (quickPopResult.popResultSelect == PopResultSelect.one) {
          final PoolGetController fragmentPoolGetController = Get.find<PoolGetController>();
          if (quickPopResult.value is PoolType) {
            await fragmentPoolGetController.updateLogic.to(quickPopResult.value! as PoolType);
            return true;
          }
        }
        return false;
      },
    );
  }

  @override
  bool whenException(Object? exception, StackTrace? stackTrace) {
    SbLogger(
      code: null,
      viewMessage: null,
      data: null,
      description: null,
      exception: exception,
      stackTrace: stackTrace,
    );
    return false;
  }
}
