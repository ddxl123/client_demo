import 'package:demo/muc/view/homepage/selectpool/SelectPoolRoute.dart';
import 'package:demo/util/SbHelper.dart';
import 'package:demo/util/sbfreebox/SbFreeBoxController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageGetController extends GetxController {
  SbFreeBoxController sbFreeBoxController = SbFreeBoxController();

  void toSelectPool(Rect triggerRect) {
    SbHelper().getNavigator!.push(SelectPoolRoute(triggerRect: triggerRect));
  }
}
