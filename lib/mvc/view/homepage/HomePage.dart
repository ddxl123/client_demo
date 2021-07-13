import 'package:demo/global/Global.dart';
import 'package:demo/mvc/controller/appinit/FloatingBallController.dart';
import 'package:demo/mvc/controller/homepage/HomePageController.dart';
import 'package:demo/util/sbfreebox/SbFreeBox.dart';
import 'package:demo/util/sbfreebox/SbFreeBoxWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final HomePageController _homePageController = Get.put(HomePageController());
  final FloatingBallController _sqliteDataFloatingBall =
      Get.put(FloatingBallController());

  @override
  Widget build(BuildContext context) {
    return SbFreeBox(
      sbFreeBoxController: _homePageController.sbFreeBoxController,
      boxWidth: screenSize.width,
      boxHeight: screenSize.height,
      fixedLayerWidgets: _fixedLayerWidgets(),
      freeMoveScaleLayerWidgets: _freeMoveScaleLayerWidgets(),
    );
  }

  Stack _fixedLayerWidgets() {
    return Stack(
      children: <Positioned>[
        _bottomWidgets(),
      ],
    );
  }

  Positioned _bottomWidgets() {
    return Positioned(
      bottom: 0,
      child: Container(
        /// Row在Stack中默认不是撑满宽度
        width: screenSize.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
                child: TextButton(onPressed: () {}, child: const Text('发现'))),
            Expanded(
              child: StatefulBuilder(
                builder: (BuildContext btCtx, SetState setState) {
                  return TextButton(
                    onPressed: () {},
                    child: const Text('aaa'),
                  );
                },
              ),
            ),
            Expanded(
                child: TextButton(onPressed: () {}, child: const Text('我'))),
          ],
        ),
      ),
    );
  }

  SbFreeBoxStack _freeMoveScaleLayerWidgets() {
    return SbFreeBoxStack(
      builder:
          (BuildContext context, void Function(void Function()) bSetState) {
        return <SbFreeBoxPositioned>[
          SbFreeBoxPositioned(
            boxPosition: const Offset(-100, -100),
            child: TextButton(
              child: const Text('button1'),
              onPressed: () {},
            ),
          ),
          SbFreeBoxPositioned(
            boxPosition: Offset.zero,
            child: TextButton(
              child: const Text('button1'),
              onPressed: () {},
            ),
          ),
        ];
      },
    );
  }
}
