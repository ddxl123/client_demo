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
  final List<FragmentPoolNodeVO> currentPoolData = <FragmentPoolNodeVO>[
    FragmentPoolNodeVO()
      ..title = '123'
      ..easyPosition = '345',
    FragmentPoolNodeVO()
      ..title = '哈哈哈哈'
      ..easyPosition = '-123,-345',
  ];

  /// 全部池的【临时固定相机】。
  ///
  /// 当【临时固定相机】为空时，定位到【持久化存储的固定相机】，若【持久化存储的固定相机】为空时，定位到 zero；
  ///
  /// 当【临时固定相机】不为空时，优先定位到【临时固定相机】。
  final Map<FragmentPoolType, FreeBoxCamera> _poolTempFixedCameras = <FragmentPoolType, FreeBoxCamera>{};

  /// 获取当前池的【临时相机】。
  FreeBoxCamera getCurrentPoolTampFixedCamera() {
    if (_poolTempFixedCameras.containsKey(currentPoolType) && _poolTempFixedCameras[currentPoolType] != null) {
      return _poolTempFixedCameras[currentPoolType]!;
    }
    // TODO: 否则获取【持久化存储的固定相机】
    return FreeBoxCamera(easyPosition: Offset.zero, scale: 1);
  }

  /// 跳转到指定碎片池。
  ///
  /// 若当前池就是 [toPoolType]，则会重新进入当前池。
  Future<void> to(FragmentPoolType toPoolType) async {
    // 异步获取 [toPoolType] 的池数据。

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

    // 设置 [currentPoolType]。
    currentPoolType = toPoolType;

    // 设置 [currentPoolData]。

    // setState 池。
    update();

    // to [getCurrentPoolTampFixedCamera]
    homePageGetController.sbFreeBoxController.targetSlide(targetCamera: getCurrentPoolTampFixedCamera(), rightNow: true);
  }

  ///
}
