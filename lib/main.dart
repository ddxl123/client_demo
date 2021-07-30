import 'package:demo/util/sbbutton/SbButton.dart';
import 'package:demo/muc/view/appinitpage/AppInitPage.dart';
import 'package:demo/muc/view/homepage/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SbButtonApp(
      child: GetMaterialApp(
        home: AppInitPage(
          builder: () => HomePage(),
        ),
      ),
    );
    // return FlutterTest();
  }
}
