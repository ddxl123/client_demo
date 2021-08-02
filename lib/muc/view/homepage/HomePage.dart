import 'package:demo/global/Global.dart';
import 'package:demo/muc/getcontroller/homepage/HomePageGetController.dart';
import 'package:demo/muc/getcontroller/homepage/PoolGetController.dart';
import 'package:demo/muc/view/homepage/poolentry/PoolEntry.dart';
import 'package:demo/util/SbHelper.dart';
import 'package:demo/util/sbbutton/SbButton.dart';
import 'package:demo/util/sbfreebox/SbFreeBox.dart';
import 'package:demo/util/sbfreebox/SbFreeBoxWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final HomePageGetController _homePageController = Get.put(HomePageGetController());
  final PoolGetController _fragmentPoolGetController = Get.put(PoolGetController());

  @override
  Widget build(BuildContext context) {
    return SbButton(
      child: SbFreeBox(
        sbFreeBoxController: _homePageController.sbFreeBoxController,
        boxSize: Size(screenSize.width, screenSize.height),
        fixedLayerWidgets: _fixedLayerWidgets(context),
        freeMoveScaleLayerWidgets: _freeMoveScaleLayerWidgets(),
      ),
      onLongPressed: (PointerDownEvent event) {
        SbHelper().getNavigator!.push(PoolEntry().toLongPressPool());
      },
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
                    child: GetBuilder<PoolGetController>(
                      builder: (PoolGetController controller) {
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

  Widget _freeMoveScaleLayerWidgets() {
    return GetBuilder<PoolGetController>(
      builder: (PoolGetController fragmentPoolGetController) {
        return SbFreeBoxStack(
          builder: (BuildContext context, void Function(void Function()) bSetState) {
            return <Widget>[
              for (int i = 0; i < fragmentPoolGetController.currentPoolData.length; i++) PoolEntry().toNode(fragmentPoolGetController.currentPoolData[i]),
            ];
          },
        );
      },
    );
  }
}
