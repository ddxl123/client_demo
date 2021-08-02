import 'package:demo/data/model/MFComplete.dart';
import 'package:demo/data/model/MFFragment.dart';
import 'package:demo/data/model/MFMemory.dart';
import 'package:demo/data/model/MFRule.dart';
import 'package:demo/data/model/ModelBase.dart';
import 'package:demo/muc/getcontroller/homepage/PoolGetController.dart';
import 'package:demo/util/SbHelper.dart';

import 'AbstractMoreRoute.dart';

class MoreRouteForFragment extends AbstractMoreRoute {
  MoreRouteForFragment(PoolNodeModel poolNodeModel) : super(poolNodeModel);

  @override
  ModelBase get newModel => MFFragment.createModel(
        id: null,
        aiid: null,
        uuid: SbHelper().newUuid,
        created_at: SbHelper().newTimestamp,
        updated_at: SbHelper().newTimestamp,
        title: SbHelper().randomString(10),
        node_aiid: poolNodeModel.getCurrentNodeModel().get_aiid,
        node_uuid: poolNodeModel.getCurrentNodeModel().get_uuid,
      );
}

class MoreRouteForComplete extends AbstractMoreRoute {
  MoreRouteForComplete(PoolNodeModel poolNodeModel) : super(poolNodeModel);

  @override
  ModelBase get newModel => MFComplete.createModel(
        id: null,
        aiid: null,
        uuid: SbHelper().newUuid,
        created_at: SbHelper().newTimestamp,
        updated_at: SbHelper().newTimestamp,
        title: SbHelper().randomString(10),
        node_aiid: poolNodeModel.getCurrentNodeModel().get_aiid,
        node_uuid: poolNodeModel.getCurrentNodeModel().get_uuid,
      );
}

class MoreRouteForMemory extends AbstractMoreRoute {
  MoreRouteForMemory(PoolNodeModel poolNodeModel) : super(poolNodeModel);

  @override
  ModelBase get newModel => MFMemory.createModel(
        id: null,
        aiid: null,
        uuid: SbHelper().newUuid,
        created_at: SbHelper().newTimestamp,
        updated_at: SbHelper().newTimestamp,
        title: SbHelper().randomString(10),
        node_aiid: poolNodeModel.getCurrentNodeModel().get_aiid,
        node_uuid: poolNodeModel.getCurrentNodeModel().get_uuid,
      );
}

class MoreRouteForRule extends AbstractMoreRoute {
  MoreRouteForRule(PoolNodeModel poolNodeModel) : super(poolNodeModel);

  @override
  ModelBase get newModel => MFRule.createModel(
        id: null,
        aiid: null,
        uuid: SbHelper().newUuid,
        created_at: SbHelper().newTimestamp,
        updated_at: SbHelper().newTimestamp,
        title: SbHelper().randomString(10),
        node_aiid: poolNodeModel.getCurrentNodeModel().get_aiid,
        node_uuid: poolNodeModel.getCurrentNodeModel().get_uuid,
      );
}
