import 'package:flutter/material.dart';

class StatefulInitBuilder extends StatefulWidget {
  const StatefulInitBuilder({required this.init, required this.builder});

  final void Function(State state) init;
  final Widget Function(State state) builder;

  @override
  _StatefulInitBuilderState createState() => _StatefulInitBuilderState();
}

class _StatefulInitBuilderState extends State<StatefulInitBuilder> {
  @override
  void initState() {
    super.initState();
    widget.init(this);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(this);
  }
}
