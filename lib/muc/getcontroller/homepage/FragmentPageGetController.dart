import 'package:demo/muc/getcontroller/GetControllerBase.dart';
import 'package:demo/muc/update/homepage/FragmentPageUpdate.dart';

class FragmentPageGetController extends GetControllerBase<FragmentPageGetController, FragmentPageUpdate> {
  FragmentPageGetController() : super(FragmentPageUpdate());

  int? currentFragmentAiid;
  String? currentFragmentUuid;
}
