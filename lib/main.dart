import 'package:demo/mvc/view/homepage/HomePage.dart';
import 'package:demo/test/FlutterTest.dart';
import 'package:demo/util/sbbutton/SbButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'mvc/view/appinitpage/AppInitPage.dart';

void main() {
  runApp(FlutterTest());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppInitPage(
      child: SbButtonApp(
        child: GetMaterialApp(
          home: Material(
            child: HomePage(),
          ),
        ),
      ),
    );
  }
}
