import 'package:demo/muc/getcontroller/homepage/FragmentPageGetController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FragmentPage extends StatelessWidget {
  FragmentPage(int? currentFragmentAiid, String? currentFragmentUuid) {
    fragmentPageGetController.currentFragmentAiid = currentFragmentAiid;
    fragmentPageGetController.currentFragmentUuid = currentFragmentUuid;
  }

  final FragmentPageGetController fragmentPageGetController = Get.put(FragmentPageGetController());

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('data'),
    );
  }
}
