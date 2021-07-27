import 'package:demo/util/sbbutton/Global.dart';
import 'package:demo/util/sblogger/SbLogger.dart';
import 'package:demo/util/sbroundedbox/SbRoundedBox.dart';
import 'package:demo/util/sbroute/AutoPosition.dart';
import 'package:demo/util/sbroute/SbPopResult.dart';
import 'package:demo/util/sbroute/SbRoute.dart';
import 'package:demo/vc/getcontroller/homepage/FragmentPoolGetController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LongPressFragmentPoolRoute extends SbRoute {
  @override
  List<Widget> body() {
    final Offset position = touchPosition;
    return <AutoPositioned>[
      AutoPositioned(
        touchPosition: position,
        child: SbRoundedBox(
          children: <Widget>[
            TextButton(
              child: const Text('随机创建节点'),
              onPressed: () async {
                final FragmentPoolGetController fragmentPoolGetController = Get.find<FragmentPoolGetController>();
                await fragmentPoolGetController.insertNewNode(position);
              },
            ),
            TextButton(
              child: const Text('删除节点'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    ];
  }

  @override
  bool whenException(Object exception, StackTrace stackTrace) {
    sbLogger(message: 'err: ', exception: exception, stackTrace: stackTrace);
    return false;
  }

  @override
  Future<bool> whenPop(SbPopResult? popResult) async {
    if (popResult == null || popResult.popResultSelect == PopResultSelect.clickBackground) {
      return true;
    }
    return false;
  }
}
