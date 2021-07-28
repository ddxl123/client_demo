import 'dart:async';

import 'package:demo/data/model/MPnComplete.dart';
import 'package:demo/data/model/MPnFragment.dart';
import 'package:demo/data/model/MPnMemory.dart';
import 'package:demo/data/model/MPnRule.dart';
import 'package:demo/data/model/ModelBase.dart';
import 'package:demo/data/model/ModelManager.dart';
import 'package:demo/data/sqlite/sqliter/OpenSqlite.dart';
import 'package:demo/data/vo/VOBase.dart';
import 'package:demo/util/SbHelper.dart';
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
      case MPnFragment:
        final MPnFragment pnFragment = model as MPnFragment;
        _easyPosition = pnFragment.get_easy_position;
        _title = pnFragment.get_title;
        break;
      case MPnMemory:
        final MPnMemory pnMemory = model as MPnMemory;
        _easyPosition = pnMemory.get_easy_position;
        _title = pnMemory.get_title;
        break;
      case MPnComplete:
        final MPnComplete pnComplete = model as MPnComplete;
        _easyPosition = pnComplete.get_easy_position;
        _title = pnComplete.get_title;
        break;
      case MPnRule:
        final MPnRule pnRule = model as MPnRule;
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

  Future<List<FragmentPoolNodeVO>> queryAll(
    FragmentPoolType fragmentPoolType,
    FragmentPoolGetController fragmentPoolGetController,
  ) async {
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

    return (await fragmentPoolGetController.select<List<FragmentPoolNodeVO>>(
          fragmentPoolType: fragmentPoolType,
          fragmentPoolCallback: () async {
            return createFroms(await query(MPnFragment().tableName));
          },
          memoryPoolCallback: () async {
            return createFroms(await query(MPnMemory().tableName));
          },
          completePoolCallback: () async {
            return createFroms(await query(MPnComplete().tableName));
          },
          rulePoolCallback: () async {
            return createFroms(await query(MPnRule().tableName));
          },
        )) ??
        <FragmentPoolNodeVO>[];
  }

  Future<FragmentPoolNodeVO> insertAndGetVo(
    FragmentPoolType fragmentPoolType,
    Offset position,
    FragmentPoolGetController fragmentPoolGetController,
  ) async {
    final HomePageGetController homePageGetController = Get.find<HomePageGetController>();
    final Offset offset = homePageGetController.sbFreeBoxController.screenToBoxActual(position);
    final String easyPosition = '${offset.dx},${offset.dy}';
    sbLogger(message: offset.toString());

    return (await fragmentPoolGetController.select<FragmentPoolNodeVO>(
      fragmentPoolType: fragmentPoolType,
      fragmentPoolCallback: () async {
        final MPnFragment pnFragment = MPnFragment.createModel(
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
        final MPnMemory pnMemory = MPnMemory.createModel(
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
        final MPnComplete pnComplete = MPnComplete.createModel(
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
        final MPnRule pnRule = MPnRule.createModel(
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
