import 'package:flutter/material.dart';

import 'Global.dart';

class SbFreeBoxController {
  ///

  /// 当前缩放值,默认必须 1。
  double scale = 1;

  /// 当前偏移值,默认必须 (0,0)。
  Offset offset = const Offset(0, 0);

  /// 整个 box 的 setState。
  late final void Function(void Function()) sbFreeBoxSetState;

  /// 惯性滑动的动画控制器，
  late final AnimationController inertialSlideAnimationController;

  /// 目标滑动的动画控制器。
  late final AnimationController targetSlideAnimationController;

  /// 有关位置的动画片段。
  late Animation<Offset> _offsetAnimation;

  /// 有关缩放的动画片段。
  late Animation<double> _scaleAnimation;

  /// 有关缩放的变换标记。
  double _lastTempScale = 1;

  /// 有关位置的缩放标记。
  Offset _lastTempTouchPosition = const Offset(0, 0);

  /// 是否禁用触摸事件
  bool _isDisableTouch = false;

  /// 是否禁用 end 触摸事件。目的是为了防止接触禁用后，end 函数体内任务仍然被触发
  bool _isDisableEndTouch = false;

  void dispose() {
    inertialSlideAnimationController.dispose();
    targetSlideAnimationController.dispose();
  }

  /// touch 事件
  void onScaleStart(ScaleStartDetails details) {
    if (_isDisableTouch) {
      return;
    }

    /// 停止所有滑动动画
    inertialSlideAnimationController.stop();
    targetSlideAnimationController.stop();

    /// 重置上一次 [临时缩放] 和 [临时触摸位置]
    _lastTempScale = 1;
    _lastTempTouchPosition = details.localFocalPoint;

    sbFreeBoxSetState(() {});
  }

  void onScaleUpdate(ScaleUpdateDetails details) {
    if (_isDisableTouch) {
      return;
    }

    /// 进行缩放
    final double deltaScale = details.scale - _lastTempScale;
    scale *= 1 + deltaScale;

    /// 缩放后的位置偏移
    final Offset pivotDeltaOffset =
        (offset - details.localFocalPoint) * deltaScale;
    offset += pivotDeltaOffset;

    /// 非缩放的位置偏移
    final Offset deltaOffset = details.localFocalPoint - _lastTempTouchPosition;
    offset += deltaOffset;

    /// 变换上一次 [临时缩放] 和 [临时触摸位置]
    _lastTempScale = details.scale;
    _lastTempTouchPosition = details.localFocalPoint;

    sbFreeBoxSetState(() {});
  }

  void onScaleEnd(ScaleEndDetails details) {
    if (_isDisableTouch || _isDisableEndTouch) {
      _isDisableEndTouch = false;
      return;
    }
    _inertialSlide(details);
  }

  /// 惯性滑动
  void _inertialSlide(ScaleEndDetails details) {
    // 持续时间
    inertialSlideAnimationController.duration =
        const Duration(milliseconds: 500);
    // 结束的位置
    final Offset endOffset = offset +
        Offset(details.velocity.pixelsPerSecond.dx / 10,
            details.velocity.pixelsPerSecond.dy / 10);
    // 配置惯性滑动
    _offsetAnimation = inertialSlideAnimationController
        .drive(CurveTween(curve: Curves.easeOutCubic))
        .drive(Tween<Offset>(begin: offset, end: endOffset));

    // 执行惯性滑动
    inertialSlideAnimationController.forward(from: 0.0);
    inertialSlideAnimationController.addListener(_inertialSlideListener);
  }

  /// 惯性滑动监听
  void _inertialSlideListener() {
    offset = _offsetAnimation.value;

    /// 被 stop() 或 动画播放完成 时, removeListener()
    if (inertialSlideAnimationController.isDismissed ||
        inertialSlideAnimationController.isCompleted) {
      inertialSlideAnimationController.removeListener(_inertialSlideListener);
    }

    sbFreeBoxSetState(() {});
  }

  /// 禁用触摸事件。
  void disableTouch(bool isDisable) {
    if (isDisable) {
      _isDisableTouch = true;
      _isDisableEndTouch = true;
    } else {
      _isDisableTouch = false;
    }
  }

  /// 屏幕坐标转盒子坐标
  ///
  /// 减去 [sbFreeBoxBodyOffset] 目的之一是为了不让 多位数 的结果存储，而只存储非偏移的数据，例如，只存 Offset(123,456)，而不存 Offset(10123,10456)。
  ///
  /// 注意，是基于 [screenPosition]\ [offset]\[scale] 属性定位。
  Offset screenToBoxTransform(Offset screenPosition) {
    return (screenPosition - offset) / scale - sbFreeBoxBodyOffset;
  }

  /// 滑动至目标位置
  ///
  /// 初始化时要滑动到 负 [sbFreeBoxBodyOffset] 的位置，原因是左上位置是界限，元素会被切除渲染。
  void targetSlide({
    required Offset targetOffset,
    required double targetScale,
    required bool rightNow,
  }) {
    if (rightNow) {
      offset = targetOffset - sbFreeBoxBodyOffset;
      targetScale = 1.0;
      targetSlideAnimationController.removeListener(_targetSlideListener);
      sbFreeBoxSetState(() {});
      return;
    }
    targetSlideAnimationController.duration = const Duration(seconds: 1);
    _offsetAnimation = targetSlideAnimationController
        .drive(CurveTween(curve: Curves.easeInOutBack))
        .drive(Tween<Offset>(
          begin: offset,
          end: targetOffset - sbFreeBoxBodyOffset,
        ));
    _scaleAnimation = targetSlideAnimationController
        .drive(CurveTween(curve: Curves.easeInOutBack))
        .drive(Tween<double>(
          begin: scale,
          end: targetScale,
        ));
    targetSlideAnimationController.forward(from: 0.4);
    targetSlideAnimationController.addListener(_targetSlideListener);
  }

  /// 滑动至目标位置监听
  void _targetSlideListener() {
    offset = _offsetAnimation.value;
    scale = _scaleAnimation.value;

    /// 被 stop() 或 动画播放完成 时, removeListener()
    if (targetSlideAnimationController.isDismissed ||
        targetSlideAnimationController.isCompleted) {
      targetSlideAnimationController.removeListener(_targetSlideListener);
    }

    sbFreeBoxSetState(() {});
  }
}
