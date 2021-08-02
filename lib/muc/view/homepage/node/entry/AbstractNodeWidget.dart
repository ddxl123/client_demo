import 'package:demo/muc/getcontroller/homepage/PoolGetController.dart';
import 'package:demo/muc/view/homepage/poolentry/AbstractPoolEntry.dart';
import 'package:demo/util/SbHelper.dart';
import 'package:demo/util/sbbutton/SbButton.dart';
import 'package:demo/util/sbfreebox/SbFreeBoxWidget.dart';
import 'package:flutter/material.dart';

abstract class AbstractNodeWidget extends AbstractPoolEntryWidget {
  const AbstractNodeWidget(PoolNodeModel poolNodeModel) : super(poolNodeModel);

  @override
  Widget build(BuildContext context) {
    return SbFreeBoxPositioned(
      easyPosition: easyPosition,
      child: SbButton(
        child: Material(
          child: Text(nodeTitle),
        ),
        onLongPressed: (_) {
          SbHelper().getNavigator!.push(onLongPressedRoute);
        },
        onUp: (_) {
          SbHelper().getNavigator!.push(onUpRoute);
        },
      ),
    );
  }

  Offset get easyPosition;

  String get nodeTitle;

  Route<void> get onLongPressedRoute;

  Route<void> get onUpRoute;
}
