import 'package:demo/data/model/ModelBase.dart';
import 'package:demo/util/sbroute/SbRoute.dart';
import 'package:demo/util/sheetroute/SbSheetRoute.dart';

/// [PNM] 池节点模型。
abstract class RoutePoolEntryBase<PNM extends ModelBase> extends SbRoute {
  RoutePoolEntryBase(this.poolNodeModel);

  final PNM poolNodeModel;
}

/// [PNM] 池节点模型。
abstract class SheetRoutePoolEntryBase<PNM extends ModelBase, D> extends SbSheetRoute<D> {
  SheetRoutePoolEntryBase(this.poolNodeModel);

  final PNM poolNodeModel;
}
