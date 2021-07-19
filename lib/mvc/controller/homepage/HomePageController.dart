import 'package:demo/mvc/view/homepage/SelectPoolRoute.dart';
import 'package:demo/util/sbfreebox/SbFreeBoxController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  SbFreeBoxController sbFreeBoxController = SbFreeBoxController();

  @override
  void onInit() {
    super.onInit();
    print('onInit');
  }

  void toSelectPool(Rect triggerRect) {
    navigator!.push<dynamic>(SelectPoolRoute(triggerRect: triggerRect));
  }
}
