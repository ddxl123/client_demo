import 'package:demo/data/model/ModelBase.dart';
import 'package:demo/data/model/PnComplete.dart';
import 'package:demo/data/model/PnFragment.dart';
import 'package:demo/data/model/PnMemory.dart';
import 'package:demo/data/model/PnRule.dart';
import 'package:demo/data/vo/VOBase.dart';
import 'package:demo/util/sblogger/SbLogger.dart';
import 'package:flutter/material.dart';

class FragmentPoolNodeVO extends VOBase {
  String? _title;
  String? _easyPosition;

  String getTitle() => _title ?? '0,0';

  Offset getEasyPositionToOffset() {
    try {
      final List<String> posStr = _easyPosition!.split(',');
      if (posStr.length != 2) {
        throw 'length err!';
      }
      return Offset(double.parse(posStr.first), double.parse(posStr.last));
    } catch (e, st) {
      sbLogger(message: '获取 easyPosition 异常！', exception: e, stackTrace: st);
      return Offset.zero;
    }
  }

  @override
  FragmentPoolNodeVO from(ModelBase model) {
    switch (model.runtimeType) {
      case PnFragment:
        final PnFragment pnFragment = model as PnFragment;
        _easyPosition = pnFragment.get_easy_position;
        _title = pnFragment.get_title;
        break;
      case PnMemory:
        final PnMemory pnMemory = model as PnMemory;
        _easyPosition = pnMemory.get_easy_position;
        _title = pnMemory.get_title;
        break;
      case PnComplete:
        final PnComplete pnComplete = model as PnComplete;
        _easyPosition = pnComplete.get_easy_position;
        _title = pnComplete.get_title;
        break;
      case PnRule:
        final PnRule pnRule = model as PnRule;
        _easyPosition = pnRule.get_easy_position;
        _title = pnRule.get_title;
        break;
      default:
        throw 'unknown model: $model';
    }
    return this;
  }

  @override
  List<FragmentPoolNodeVO> froms(List<ModelBase> models) {
    final List<FragmentPoolNodeVO> vos = <FragmentPoolNodeVO>[];
    for (final ModelBase model in models) {
      // 必须用类调用来构建新对象。
      vos.add(FragmentPoolNodeVO().from(model));
    }
    return vos;
  }
}
