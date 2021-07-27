import 'package:flutter/material.dart';

import 'LoadAreaController.dart';
import 'SbSheetRouteController.dart';

class LoadAreaWidget<T, M> extends StatefulWidget {
  const LoadAreaWidget(this.sbSheetPageController);

  final SbSheetPageController<T, M> sbSheetPageController;

  @override
  _LoadAreaWidgetState<T, M> createState() => _LoadAreaWidgetState<T, M>();
}

class _LoadAreaWidgetState<T, M> extends State<LoadAreaWidget<T, M>> {
  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      fillOverscroll: true,
      child: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: Text(widget.sbSheetPageController.loadAreaController.loadAreaStatus.text),
      ),
    );
  }
}
