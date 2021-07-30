import 'dart:async';

import 'package:demo/data/model/MPnComplete.dart';
import 'package:demo/data/model/MPnFragment.dart';
import 'package:demo/data/model/MPnMemory.dart';
import 'package:demo/data/model/MPnRule.dart';
import 'package:demo/data/model/ModelBase.dart';
import 'package:demo/muc/getcontroller/GetControllerBase.dart';
import 'package:demo/muc/update/homepage/PoolUpdate.dart';
import 'package:demo/util/sbfreebox/SbFreeBoxController.dart';
import 'package:flutter/cupertino.dart';

enum PoolType {
  none,
  fragment,
  memory,
  complete,
  rule,
}

extension PoolTypeExt on PoolType {
  String get text {
    switch (index) {
      case 0:
        return 'none';
      case 1:
        return '碎片池';
      case 2:
        return '记忆池';
      case 3:
        return '完成池';
      case 4:
        return '记忆池';
      default:
        return 'err';
    }
  }
}

class PoolNodeModel {
  PoolNodeModel();

  PoolNodeModel.from(ModelBase model) {
    switch (model.runtimeType) {
      case MPnFragment:
        currentNodeModel = model;
        break;
      case MPnMemory:
        currentNodeModel = model;
        break;
      case MPnComplete:
        currentNodeModel = model;
        break;
      case MPnRule:
        currentNodeModel = model;
        break;
      default:
        throw 'unknown model: $model';
    }
  }

  late ModelBase currentNodeModel;
}

class PoolGetController extends GetControllerBase<PoolGetController, PoolUpdate> {
  ///

  PoolGetController() : super(PoolUpdate());

  /// 当前碎片池类型。
  PoolType currentPoolType = PoolType.none;

  /// 当前碎片池的数据。
  final List<PoolNodeModel> currentPoolData = <PoolNodeModel>[];

  /// 全部池的【临时固定相机】。
  ///
  /// 当【临时固定相机】为空时，定位到【持久化存储的固定相机】，若【持久化存储的固定相机】为空时，定位到 zero；
  ///
  /// 当【临时固定相机】不为空时，优先定位到【临时固定相机】。
  final Map<PoolType, FreeBoxCamera> poolTempFixedCameras = <PoolType, FreeBoxCamera>{};

  @override
  void onReady() {
    super.onReady();
    // 初始化后进入默认池。
    updateLogic.to(PoolType.fragment);
  }

  /// 获取当前池的【临时相机】。
  FreeBoxCamera get getCurrentPoolTampFixedCamera {
    if (poolTempFixedCameras.containsKey(currentPoolType) && poolTempFixedCameras[currentPoolType] != null) {
      return poolTempFixedCameras[currentPoolType]!;
    }
    // TODO: 否则获取【持久化存储的固定相机】
    return FreeBoxCamera(easyPosition: Offset.zero, scale: 1);
  }

  FutureOr<T?> select<T>({
    required PoolType fragmentPoolType,
    required FutureOr<T?> fragmentPoolCallback(),
    required FutureOr<T?> memoryPoolCallback(),
    required FutureOr<T?> completePoolCallback(),
    required FutureOr<T?> rulePoolCallback(),
  }) async {
    switch (fragmentPoolType) {
      case PoolType.fragment:
        return await fragmentPoolCallback();
      case PoolType.memory:
        return await memoryPoolCallback();
      case PoolType.complete:
        return await completePoolCallback();
      case PoolType.rule:
        return await rulePoolCallback();
      default:
        throw 'unknown fragmentPoolType: $fragmentPoolType';
    }
  }

  ///
}
