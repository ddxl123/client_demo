import 'dart:async';

import 'package:demo/data/vo/FragmentPoolNodeVO.dart';
import 'package:demo/util/sbfreebox/SbFreeBoxController.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'HomePageGetController.dart';

enum FragmentPoolType {
  none,
  fragment,
  memory,
  complete,
  rule,
}

extension FragmentPoolTypeExt on FragmentPoolType {
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

class FragmentPoolGetController extends GetxController {
  ///

  @override
  void onReady() {
    super.onReady();
    // 初始化后进入默认池。
    to(FragmentPoolType.fragment);
  }

  /// 当前碎片池类型。
  FragmentPoolType currentPoolType = FragmentPoolType.none;

  /// 当前碎片池的数据。
  final List<FragmentPoolNodeVO> currentPoolData = <FragmentPoolNodeVO>[];

  /// 全部池的【临时固定相机】。
  ///
  /// 当【临时固定相机】为空时，定位到【持久化存储的固定相机】，若【持久化存储的固定相机】为空时，定位到 zero；
  ///
  /// 当【临时固定相机】不为空时，优先定位到【临时固定相机】。
  final Map<FragmentPoolType, FreeBoxCamera> _poolTempFixedCameras = <FragmentPoolType, FreeBoxCamera>{};

  /// 获取当前池的【临时相机】。
  FreeBoxCamera get getCurrentPoolTampFixedCamera {
    if (_poolTempFixedCameras.containsKey(currentPoolType) && _poolTempFixedCameras[currentPoolType] != null) {
      return _poolTempFixedCameras[currentPoolType]!;
    }
    // TODO: 否则获取【持久化存储的固定相机】
    return FreeBoxCamera(easyPosition: Offset.zero, scale: 1);
  }

  FutureOr<T?> select<T>({
    required FragmentPoolType fragmentPoolType,
    required FutureOr<T?> fragmentPoolCallback(),
    required FutureOr<T?> memoryPoolCallback(),
    required FutureOr<T?> completePoolCallback(),
    required FutureOr<T?> rulePoolCallback(),
  }) async {
    switch (fragmentPoolType) {
      case FragmentPoolType.fragment:
        return await fragmentPoolCallback();
      case FragmentPoolType.memory:
        return await memoryPoolCallback();
      case FragmentPoolType.complete:
        return await completePoolCallback();
      case FragmentPoolType.rule:
        return await rulePoolCallback();
      default:
        throw 'unknown fragmentPoolType: $fragmentPoolType';
    }
  }

  /// 给当前池添加新节点。
  Future<void> insertNewNode(Offset position) async {
    currentPoolData.add(await FragmentPoolNodeVO().insertAndGetVo(currentPoolType, position, this));
    update();
  }

  /// 跳转到指定碎片池。
  ///
  /// 若当前池就是 [toPoolType]，则会重新进入当前池。
  Future<void> to(FragmentPoolType toPoolType) async {
    // 设置 [toPoolType] 前的临时相机。
    final HomePageGetController homePageGetController = Get.find<HomePageGetController>();
    if (_poolTempFixedCameras.containsKey(currentPoolType)) {
      /// 为什么临时存储的对象必须新建？因为可能还是引用的地址是控制器中的对象。
      _poolTempFixedCameras[currentPoolType] = FreeBoxCamera(
        easyPosition: homePageGetController.sbFreeBoxController.freeBoxCamera.easyPosition,
        scale: homePageGetController.sbFreeBoxController.freeBoxCamera.scale,
      );
    } else {
      _poolTempFixedCameras.addAll(<FragmentPoolType, FreeBoxCamera>{
        currentPoolType: FreeBoxCamera(
          easyPosition: homePageGetController.sbFreeBoxController.freeBoxCamera.easyPosition,
          scale: homePageGetController.sbFreeBoxController.freeBoxCamera.scale,
        )
      });
    }

    // 设置 [currentPoolData]。
    currentPoolData.clear();
    currentPoolData.addAll(await FragmentPoolNodeVO().queryAll(toPoolType, this));

    // 全部成功后，设置 [currentPoolType]。
    currentPoolType = toPoolType;

    // setState 池。
    update();

    // to [getCurrentPoolTampFixedCamera]
    homePageGetController.sbFreeBoxController.targetSlide(targetCamera: getCurrentPoolTampFixedCamera, rightNow: true);
  }

  ///
}
