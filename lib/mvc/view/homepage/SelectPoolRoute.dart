import 'package:demo/global/Global.dart';
import 'package:demo/util/sbroundedbox/SbRoundedBox.dart';
import 'package:demo/util/sbroute/SbPopResult.dart';
import 'package:demo/util/sbroute/SbRoute.dart';
import 'package:flutter/material.dart';

class SelectPoolRoute extends SbRoute {
  SelectPoolRoute({required Rect triggerRect})
      : super(triggerRect: triggerRect);

  @override
  List<Widget> body() {
    return <Widget>[
      Positioned(
        bottom: screenSize.height - triggerRect!.top,
        right: 0,
        left: 0,
        child: const SbRoundedBox(
          children: <Widget>[
            Text('测试11111'),
            Text('测试11111'),
            Text('测试11111'),
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
    return false;
  }
}
