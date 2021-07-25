import 'package:demo/global/Global.dart';
import 'package:demo/util/sblogger/SbLogger.dart';
import 'package:demo/util/sbroundedbox/SbRoundedBox.dart';
import 'package:demo/util/sbroute/SbPopResult.dart';
import 'package:demo/util/sbroute/SbRoute.dart';
import 'package:demo/vc/getcontroller/homepage/FragmentPoolGetController.dart';
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
                Get.back<SbPopResult>(result: SbPopResult(popResultSelect: PopResultSelect.one, value: FragmentPoolType.fragment));
              },
            ),
            TextButton(
              child: const Text('记忆池'),
              onPressed: () {
                Get.back<SbPopResult>(result: SbPopResult(popResultSelect: PopResultSelect.one, value: FragmentPoolType.memory));
              },
            ),
            TextButton(
              child: const Text('完成池'),
              onPressed: () {
                Get.back<SbPopResult>(result: SbPopResult(popResultSelect: PopResultSelect.one, value: FragmentPoolType.complete));
              },
            ),
          ],
        ),
      ),
    ];
  }

  @override
  Future<bool> whenPop(SbPopResult? popResult) async {
    if (popResult == null) {
      return true;
    }
    if (popResult.popResultSelect == PopResultSelect.clickBackground) {
      return true;
    }
    if (popResult.popResultSelect == PopResultSelect.one) {
      final FragmentPoolGetController fragmentPoolGetController = Get.find<FragmentPoolGetController>();
      if (popResult.value is FragmentPoolType) {
        await fragmentPoolGetController.to(popResult.value! as FragmentPoolType);
        return true;
      }
    }
    return false;
  }

  @override
  bool whenException(Object exception, StackTrace stackTrace) {
    sbLogger(message: 'err: ', exception: exception, stackTrace: stackTrace);
    return false;
  }
}
