import 'package:demo/data/vo/VOBase.dart';
import 'package:demo/util/sblogger/SbLogger.dart';
import 'package:flutter/material.dart';

class FragmentPoolNodeVO extends VOBase {
  String easyPosition = '0,0';

  String title = 'title is null';

  Offset getEasyPositionToOffset() {
    try {
      final List<String> posStr = easyPosition.split(',');
      if (posStr.length != 2) {
        throw 'length err!';
      }
      return Offset(double.parse(posStr.first), double.parse(posStr.last));
    } catch (e, st) {
      sbLogger(message: '获取 easyPosition 异常！', exception: e, stackTrace: st);
      return Offset.zero;
    }
  }
}
