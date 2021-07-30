import 'package:demo/muc/getcontroller/homepage/HomePageGetController.dart';
import 'package:demo/muc/getcontroller/homepage/PoolGetController.dart';
import 'package:demo/util/sbbutton/Global.dart';
import 'package:demo/util/sblogger/SbLogger.dart';
import 'package:demo/util/sbroundedbox/SbRoundedBox.dart';
import 'package:demo/util/sbroute/AutoPosition.dart';
import 'package:demo/util/sbroute/SbPopResult.dart';
import 'package:demo/util/sbroute/SbRoute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class LongPressPoolRouteEntryBase extends SbRoute {
  @override
  List<Widget> body() {
    final Offset position = touchPosition;
    return <AutoPositioned>[
      AutoPositioned(
        touchPosition: position,
        child: SbRoundedBox(
          children: <Widget>[
            TextButton(
              child: const Text('创建节点'),
              onPressed: () async {
                final Offset offset = Get.find<HomePageGetController>().sbFreeBoxController.screenToBoxActual(position);
                final String easyPosition = '${offset.dx},${offset.dy}';
                final PoolNodeModel poolNodeModel = await createNewNode(easyPosition);
                Get.find<PoolGetController>().updateLogic.insertNewNode(poolNodeModel);
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
    return await quickWhenPop(popResult, (SbPopResult quickPopResult) async => false);
  }

  Future<PoolNodeModel> createNewNode(String easyPosition);
}
