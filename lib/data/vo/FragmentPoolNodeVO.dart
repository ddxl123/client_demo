import 'dart:async';

import 'package:demo/data/model/ModelBase.dart';
import 'package:demo/data/model/ModelManager.dart';
import 'package:demo/data/model/PnComplete.dart';
import 'package:demo/data/model/PnFragment.dart';
import 'package:demo/data/model/PnMemory.dart';
import 'package:demo/data/model/PnRule.dart';
import 'package:demo/data/sqlite/sqliter/OpenSqlite.dart';
import 'package:demo/data/vo/VOBase.dart';
import 'package:demo/util/SbHelper.dart';
import 'package:demo/util/sbbutton/Global.dart';
import 'package:demo/util/sblogger/SbLogger.dart';
import 'package:demo/vc/getcontroller/homepage/FragmentPoolGetController.dart';
import 'package:demo/vc/getcontroller/homepage/HomePageGetController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FragmentPoolNodeVO extends VOBase {
  FragmentPoolNodeVO();

  @override
  FragmentPoolNodeVO.createFrom(ModelBase model) : super.createFrom(model) {
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
  }

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

  Future<List<FragmentPoolNodeVO>> queryAll(FragmentPoolType fragmentPoolType) async {
    Future<List<ModelBase>> query(String tableName) async {
      return await ModelManager.queryRowsAsModels(connectTransaction: null, tableName: tableName);
    }

    @override
    List<FragmentPoolNodeVO> createFroms(List<ModelBase> models) {
      final List<FragmentPoolNodeVO> vos = <FragmentPoolNodeVO>[];
      for (final ModelBase model in models) {
        // 必须用类调用来构建新对象。
        vos.add(FragmentPoolNodeVO.createFrom(model));
      }
      return vos;
    }

    return (await select<List<FragmentPoolNodeVO>>(
          fragmentPoolType: fragmentPoolType,
          fragmentPoolCallback: () async {
            return createFroms(await query(PnFragment().tableName));
          },
          memoryPoolCallback: () async {
            return createFroms(await query(PnMemory().tableName));
          },
          completePoolCallback: () async {
            return createFroms(await query(PnComplete().tableName));
          },
          rulePoolCallback: () async {
            return createFroms(await query(PnRule().tableName));
          },
        )) ??
        <FragmentPoolNodeVO>[];
  }

  Future<FragmentPoolNodeVO> insertAndGetVo(FragmentPoolType fragmentPoolType,Offset position) async {
    final HomePageGetController homePageGetController = Get.find<HomePageGetController>();
    final Offset offset = homePageGetController.sbFreeBoxController.screenToBoxActual(position);
    final String easyPosition = '${offset.dx},${offset.dy}';
    sbLogger(message: offset.toString());
    return (await select<FragmentPoolNodeVO>(
      fragmentPoolType: fragmentPoolType,
      fragmentPoolCallback: () async {
        final PnFragment pnFragment = PnFragment()
          ..createModel(
            id: null,
            aiid: null,
            uuid: null,
            created_at: null,
            updated_at: null,
            used_rule_aiid: null,
            easy_position: easyPosition,
            title: SbHelper().randomString(10),
          );
        await db.insert(pnFragment.tableName, pnFragment.getRowJson);
        return FragmentPoolNodeVO.createFrom(pnFragment);
      },
      memoryPoolCallback: () async {
        final PnMemory pnMemory = PnMemory()
          ..createModel(
            id: null,
            aiid: null,
            uuid: null,
            created_at: null,
            updated_at: null,
            easy_position: easyPosition,
            title: SbHelper().randomString(10),
          );
        await db.insert(pnMemory.tableName, pnMemory.getRowJson);
        return FragmentPoolNodeVO.createFrom(pnMemory);
      },
      completePoolCallback: () async {
        final PnComplete pnComplete = PnComplete()
          ..createModel(
            id: null,
            aiid: null,
            uuid: null,
            created_at: null,
            updated_at: null,
            easy_position: easyPosition,
            title: SbHelper().randomString(10),
          );
        await db.insert(pnComplete.tableName, pnComplete.getRowJson);
        return FragmentPoolNodeVO.createFrom(pnComplete);
      },
      rulePoolCallback: () async {
        final PnRule pnRule = PnRule()
          ..createModel(
            id: null,
            aiid: null,
            uuid: null,
            created_at: null,
            updated_at: null,
            easy_position: easyPosition,
            title: SbHelper().randomString(10),
          );
        await db.insert(pnRule.tableName, pnRule.getRowJson);
        return FragmentPoolNodeVO.createFrom(pnRule);
      },
    ))!;
  }
}
