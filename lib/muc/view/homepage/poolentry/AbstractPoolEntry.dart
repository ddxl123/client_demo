import 'package:demo/muc/getcontroller/homepage/PoolGetController.dart';
import 'package:demo/util/sbroute/SbRoute.dart';
import 'package:demo/util/sheetroute/SbSheetRoute.dart';
import 'package:flutter/material.dart';

abstract class AbstractPoolEntryWidget extends StatelessWidget {
  const AbstractPoolEntryWidget(this.poolNodeModel);

  final PoolNodeModel poolNodeModel;
}

abstract class AbstractPoolEntryRoute extends SbRoute {
  AbstractPoolEntryRoute(this.poolNodeModel);

  final PoolNodeModel poolNodeModel;
}

abstract class AbstractPoolEntrySheetRoute<D> extends SbSheetRoute<D> {
  AbstractPoolEntrySheetRoute(this.poolNodeModel);

  final PoolNodeModel poolNodeModel;
}
