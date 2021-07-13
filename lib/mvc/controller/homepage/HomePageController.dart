import 'package:demo/util/sbfreebox/SbFreeBoxController.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  SbFreeBoxController sbFreeBoxController = SbFreeBoxController();

  @override
  void onInit() {
    super.onInit();
    print('onInit');
  }
}
