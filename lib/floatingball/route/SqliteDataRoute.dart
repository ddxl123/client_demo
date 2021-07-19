import 'dart:ui';

import 'package:demo/global/Global.dart';
import 'package:demo/util/sbroundedbox/SbRoundedBox.dart';
import 'package:demo/util/sbroute/SbPopResult.dart';
import 'package:demo/util/sbroute/SbRoute.dart';
import 'package:flutter/material.dart';

class SqliteDataRoute extends SbRoute {
  @override
  Color get backgroundColor => Colors.pink;

  @override
  // TODO: implement backgroundOpacity
  double get backgroundOpacity => 0;

  @override
  List<Widget> body() {
    return <Widget>[
      SbRoundedBox(
        width: screenSize.width * 2 / 3,
        children: const <Widget>[
          Text('data'),
        ],
      )
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
