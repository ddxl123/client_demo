import 'package:demo/data/model/MFComplete.dart';
import 'package:demo/data/model/MFFragment.dart';
import 'package:demo/data/model/MFMemory.dart';
import 'package:demo/data/model/MFRule.dart';
import 'package:demo/muc/view/homepage/node/nodesheet/entry/AbstractNodeSheetRoute.dart';
import 'package:demo/util/SbHelper.dart';

import 'AbstractMoreRoute.dart';

class MoreRouteForFragment extends AbstractMoreRoute<MFFragment> {
  MoreRouteForFragment(AbstractNodeSheetRoute<MFFragment> abstractNodeSheetRoute) : super(abstractNodeSheetRoute);

  @override
  MFFragment get insertModel => MFFragment.createModel(
        id: null,
        aiid: null,
        uuid: SbHelper().newUuid,
        created_at: SbHelper().newTimestamp,
        updated_at: SbHelper().newTimestamp,
        title: SbHelper().randomString(10),
        node_aiid: poolNodeModel.getCurrentNodeModel().get_aiid,
        node_uuid: poolNodeModel.getCurrentNodeModel().get_uuid,
        rule_aiid: null,
        rule_uuid: null,
        father_fragment_aiid: null,
        father_fragment_uuid: null,
      );
}

class MoreRouteForComplete extends AbstractMoreRoute<MFComplete> {
  MoreRouteForComplete(AbstractNodeSheetRoute<MFComplete> abstractNodeSheetRoute) : super(abstractNodeSheetRoute);

  @override
  MFComplete get insertModel => MFComplete.createModel(
        id: null,
        aiid: null,
        uuid: SbHelper().newUuid,
        created_at: SbHelper().newTimestamp,
        updated_at: SbHelper().newTimestamp,
        title: SbHelper().randomString(10),
        node_aiid: poolNodeModel.getCurrentNodeModel().get_aiid,
        node_uuid: poolNodeModel.getCurrentNodeModel().get_uuid,
        rule_aiid: null,
        rule_uuid: null,
        fragment_aiid: null,
        fragment_uuid: null,
      );
}

class MoreRouteForMemory extends AbstractMoreRoute<MFMemory> {
  MoreRouteForMemory(AbstractNodeSheetRoute<MFMemory> abstractNodeSheetRoute) : super(abstractNodeSheetRoute);

  @override
  MFMemory get insertModel => MFMemory.createModel(
        id: null,
        aiid: null,
        uuid: SbHelper().newUuid,
        created_at: SbHelper().newTimestamp,
        updated_at: SbHelper().newTimestamp,
        title: SbHelper().randomString(10),
        node_aiid: poolNodeModel.getCurrentNodeModel().get_aiid,
        node_uuid: poolNodeModel.getCurrentNodeModel().get_uuid,
        rule_aiid: null,
        rule_uuid: null,
        fragment_aiid: null,
        fragment_uuid: null,
      );
}

class MoreRouteForRule extends AbstractMoreRoute<MFRule> {
  MoreRouteForRule(AbstractNodeSheetRoute<MFRule> abstractNodeSheetRoute) : super(abstractNodeSheetRoute);

  @override
  MFRule get insertModel => MFRule.createModel(
        id: null,
        aiid: null,
        uuid: SbHelper().newUuid,
        created_at: SbHelper().newTimestamp,
        updated_at: SbHelper().newTimestamp,
        title: SbHelper().randomString(10),
        node_aiid: poolNodeModel.getCurrentNodeModel().get_aiid,
        node_uuid: poolNodeModel.getCurrentNodeModel().get_uuid,
        father_rule_aiid: null,
        father_rule_uuid: null,
      );
}
