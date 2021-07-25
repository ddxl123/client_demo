import 'package:demo/data/sqlite/sqliter/SqliteInit.dart';
import 'package:demo/floatingball/FloatingballInit.dart';
import 'package:demo/util/sblogger/SbLogger.dart';
import 'package:flutter/material.dart';

enum AppInitStatus { ok, exception, initializing }

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
    try {
      final SqliteInitResult sqliteInitResult = await SqliteInit().init();
      FloatingBallInit().init(context);
      _appInitStatus = AppInitStatus.ok;
    } catch (e, st) {
      sbLogger(message: 'initAll err: ', exception: e, stackTrace: st);
      _appInitStatus = AppInitStatus.exception;
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (_appInitStatus) {
      case AppInitStatus.initializing:
        return const Scaffold(
          body: Center(
            child: Text('正在应用初始化中...'),
          ),
        );
      case AppInitStatus.ok:
        return widget.child;
      default:
        return const Scaffold(
          body: Center(
            child: Text('应用初始化失败！'),
          ),
        );
    }
  }
}
