import 'dart:ui';

import 'package:demo/floatingball/FloatingBallBase.dart';
import 'package:demo/floatingball/route/SqliteDataRoute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SqliteDataFloatingBall extends FloatingBallBase {
  @override
  String get floatingBallName => 'SqliteData';

  @override
  Offset get initPosition => const Offset(100, 100);

  @override
  double get radius => 70;

  @override
  void onUp(PointerUpEvent pointerUpEvent) {
    navigator!.push<Object>(SqliteDataRoute());
  }
}
