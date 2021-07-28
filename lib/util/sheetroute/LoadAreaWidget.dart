import 'package:demo/util/sheetroute/LoadAreaController.dart';
import 'package:flutter/material.dart';

class LoadAreaWidget<T, M> extends StatefulWidget {
  const LoadAreaWidget(this.loadAreaController);

  final LoadAreaController loadAreaController;

  @override
  _LoadAreaWidgetState<T, M> createState() => _LoadAreaWidgetState<T, M>();
}

class _LoadAreaWidgetState<T, M> extends State<LoadAreaWidget<T, M>> {
  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: widget.loadAreaController.currentStatusWidget(),
    );
  }
}
