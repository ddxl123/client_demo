import 'package:demo/global/Global.dart';
import 'package:demo/util/sbfreebox/SbFreeBox.dart';
import 'package:demo/util/sbfreebox/SbFreeBoxWidget.dart';
import 'package:demo/util/sblogger/SbLogger.dart';
import 'package:demo/vc/getcontroller/homepage/FragmentPoolGetController.dart';
import 'package:demo/vc/getcontroller/homepage/HomePageGetController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final HomePageGetController _homePageController = Get.put(HomePageGetController());
  final FragmentPoolGetController _fragmentPoolGetController = Get.put(FragmentPoolGetController());

  @override
  Widget build(BuildContext context) {
    return SbFreeBox(
      sbFreeBoxController: _homePageController.sbFreeBoxController,
      boxSize: Size(screenSize.width, screenSize.height),
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
            Expanded(child: TextButton(onPressed: () {}, child: const Text('发现'))),
            Expanded(
              child: SbRectWidget(
                builder: (Rect Function() getRect) {
                  return TextButton(
                    onPressed: () {
                      _homePageController.toSelectPool(getRect());
                    },
                    child: GetBuilder<FragmentPoolGetController>(
                      builder: (FragmentPoolGetController controller) {
                        return Text(controller.currentPoolType.text);
                      },
                    ),
                  );
                },
              ),
            ),
            Expanded(child: TextButton(onPressed: () {}, child: const Text('我'))),
          ],
        ),
      ),
    );
  }

  SbFreeBoxStack _freeMoveScaleLayerWidgets() {
    return SbFreeBoxStack(
      builder: (BuildContext context, void Function(void Function()) bSetState) {
        return <SbFreeBoxPositioned>[
          for (int i = 0; i < _fragmentPoolGetController.currentPoolData.length; i++)
            SbFreeBoxPositioned(
              easyPosition: _fragmentPoolGetController.currentPoolData[i].getEasyPositionToOffset(),
              child: TextButton(
                child: Text(_fragmentPoolGetController.currentPoolData[i].title),
                onPressed: () {
                  sbLogger(message: _fragmentPoolGetController.currentPoolData[i].getEasyPositionToOffset().toString());
                },
              ),
            ),
        ];
      },
    );
  }
}
