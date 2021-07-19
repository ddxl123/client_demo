import 'package:demo/global/Global.dart';
import 'package:demo/mvc/controller/homepage/HomePageController.dart';
import 'package:demo/util/sbfreebox/SbFreeBox.dart';
import 'package:demo/util/sbfreebox/SbFreeBoxWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final HomePageController _homePageController = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return SbFreeBox(
      sbFreeBoxController: _homePageController.sbFreeBoxController,
      boxWidth: screenSize.width,
      boxHeight: screenSize.height,
      fixedLayerWidgets: _fixedLayerWidgets(context),
      freeMoveScaleLayerWidgets: _freeMoveScaleLayerWidgets(),
    );
  }

  Stack _fixedLayerWidgets(BuildContext context) {
    return Stack(
      children: <Positioned>[
        _bottomWidgets(context),
      ],
    );
  }

  Positioned _bottomWidgets(BuildContext context) {
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
              child: SbRectWidget(
                builder: (Rect Function() getRect) {
                  return TextButton(
                    onPressed: () {
                      // _homePageController.toSelectPool(getRect());
                      toLoginPage();
                    },
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
