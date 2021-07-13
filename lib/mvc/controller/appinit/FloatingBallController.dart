import 'package:demo/floatingball/SqliteDataFloatingBall.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FloatingBallController extends GetxController {
  late final NavigatorState _navigatorState;

  @override
  void onReady() {
    super.onReady();
    _navigatorState = Navigator.of(Get.context!);
    _navigatorState.overlay!.insertAll(overlayEntries);
  }

  @override
  void onClose() {
    for (final OverlayEntry overlayEntry in overlayEntries) {
      overlayEntry.remove();
    }
    super.onClose();
  }

  /// 把所有要启动的悬浮球放在这里面
  final List<OverlayEntry> overlayEntries = <OverlayEntry>[
    SqliteDataFloatingBall().overlayEntry,
  ];
}
