import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class SbHelper {
  /// 生成随机小数点后 1 位的正 double 值。
  ///
  /// 范围：[0.0 ~ max.99999999999999]
  double randomDouble(int max) {
    return randomInt(max) + Random().nextDouble();
  }

  /// 生成随机正 int 值。
  ///
  /// 范围：[0 ~ max)
  int randomInt(int max) {
    return Random().nextInt(max);
  }

  /// 生成随机字符串。
  String randomString(int length) {
    const String lowerLetters = 'abcdefghijklmnopqrstuvwxyz';
    const String upperLetters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const String number = '1234567890';
    const String englishSymbols = '~`!@#\$%^&*()_-+={[}]|\\:;"\'<,>.?/';
    const String chinaSymbols = '~·！@#￥%……&*（）——-+={【}】|、：；“‘《，》。？/';
    const String chineseCharacter = '去我额人他有哦怕啊是的发给和就看了在下从吧了吗';
    const String space = ' ';
    const String all = lowerLetters + upperLetters + number + englishSymbols + chinaSymbols + chineseCharacter + space;
    String result = '';
    for (int i = 0; i < length; i++) {
      result += all[randomInt(all.length)];
    }
    return result;
  }

  /// 生成 uuid。
  String get newUuid => const Uuid().v4();

  /// 生成当前时间戳。
  int get newTimestamp => DateTime.now().millisecondsSinceEpoch;

  /// 统一获取 get 插件的 navigator，以防引用包冲突。
  NavigatorState? get getNavigator => navigator;

  Offset? str2Offset(String? offsetStr) {
    if (offsetStr == null) {
      return null;
    }
    final List<String> posStr = offsetStr.split(',');
    if (posStr.length != 2) {
      throw 'length err!';
    }
    return Offset(double.parse(posStr.first), double.parse(posStr.last));
  }
}
