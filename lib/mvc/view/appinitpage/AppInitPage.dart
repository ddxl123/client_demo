import 'package:demo/database/sqlite/SqliteInit.dart';
import 'package:demo/floatingball/FloatingballInit.dart';
import 'package:flutter/material.dart';

enum AppInitStatus { success, failure, initializing }

class AppInitPage extends StatefulWidget {
  const AppInitPage({required this.child});

  final Widget child;

  @override
  _AppInitPageState createState() => _AppInitPageState();
}

class _AppInitPageState extends State<AppInitPage> {
  AppInitStatus _appInitStatus = AppInitStatus.initializing;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(
      (Duration timeStamp) async {
        await initAll();
        setState(() {});
      },
    );
  }

  Future<void> initAll() async {
   final SqliteInitResult sqliteInitResult = await SqliteInit().init();
    floatingBallInit(context);
  }

  @override
  Widget build(BuildContext context) {
    switch (_appInitStatus) {
      case AppInitStatus.initializing:
        return const Center(
          child: Text('正在应用初始化中...'),
        );
      case AppInitStatus.success:
        return widget.child;
      default:
        return const Center(
          child: Text('应用初始化失败！'),
        );
    }
  }
}
