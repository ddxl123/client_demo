import 'package:flutter/material.dart';

import 'SbPopResult.dart';
import 'SbRouteWidget.dart';

/// [SbRoute] 具有触发返回功能的 toast。
///
/// [SbPopResult] 触发 pop 时的传参，用来识别是什么类型的 pop (物理键返回？点击背景返回？)，并根据识别结果进行对应的逻辑操作。
abstract class SbRoute extends OverlayRoute<SbPopResult> {
  ///

  SbRoute({this.triggerRect});

  // ==============================================================================
  //
  // 需实现的部分
  //

  /// [whenPop]：
  /// - 若返回 true，则异步完后整个 route 被 pop,；
  /// - 若返回 false，则异步完后 route 不进行 pop，只有等待页面被 pop。
  ///
  /// 参数值 [popResult]：
  /// - 若参数值的 [SbPopResult] 为 null，则代表(或充当)'物理返回'。
  /// - 若参数值的 [PopResultSelect] 为 [PopResultSelect.clickBackground]，则代表点击了背景。
  ///
  /// 已经被设定多次触发时只会执行第一次。
  Future<bool> whenPop(SbPopResult? popResult);

  ///初始化。
  void onInit() {}

  /// 初始化完成。
  void onRead() {}

  /// 会先执行 [build] 函数，后返回 widget。
  void onBuild() {}

  /// Widget 为 [Positioned] 或 [AutoPositioned]
  List<Widget> body();

  /// 背景不透明度
  double get backgroundOpacity => 0;

  /// 背景颜色
  Color get backgroundColor => Colors.transparent;

  /// 使该 route 弹出的 widget 的 rect。
  Rect? triggerRect;

  // ==============================================================================
  //
  // 非实现部分
  //

  /// 当前 route 的根 Widget 的 setState
  void Function(void Function())? sbRouteSetState;

  /// 是否显示 popWaiting
  bool isPopWaiting = false;

  /// 是否 pop
  bool isPop = false;

  /// 是否正在 pop 中
  bool isPopping = false;

  /// 1. 点击背景调用
  /// 2. 触发物理返回调用
  Future<void> toPop(SbPopResult? result) async {
    if (isPopping) {
      return;
    }
    isPopping = true;
    isPopWaiting = true;
    sbRouteSetState?.call(() {});

    final bool popResult = await whenPop(result);
    if (popResult) {
      isPop = true;
      didPop(null);
    } else {
      isPopping = false;
      isPopWaiting = false;
      sbRouteSetState?.call(() {});
    }
  }

  /// 物理返回 的 [result] 为 null
  @override
  bool didPop(SbPopResult? result) {
    if (isPop == true) {
      super.didPop(null);
      return true;
    } else {
      toPop(result);
      return false;
    }
  }

  @override
  Iterable<OverlayEntry> createOverlayEntries() {
    return <OverlayEntry>[
      OverlayEntry(
        builder: (_) {
          return SbRouteWidget(this);
        },
      ),
    ];
  }

  ///
}
