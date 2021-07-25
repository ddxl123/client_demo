import 'package:demo/util/sbfreebox/SbFreeBoxController.dart';
import 'package:demo/vc/view/homepage/SelectPoolRoute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageGetController extends GetxController {
  SbFreeBoxController sbFreeBoxController = SbFreeBoxController();

  void toSelectPool(Rect triggerRect) {
    navigator!.push<dynamic>(SelectPoolRoute(triggerRect: triggerRect));
  }
}
