import 'dart:ui';

import 'package:flutter/material.dart';

/// 屏幕宽高。
/// TODO: 未测试应用外悬浮框的大小是否为这个大小。
final Size screenSize = MediaQueryData.fromWindow(window).size;

/// 快捷 setState 类型
typedef SetState = void Function(void Function());
