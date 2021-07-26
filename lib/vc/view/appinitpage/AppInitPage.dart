import 'package:demo/data/sqlite/sqliter/SqliteInit.dart';
import 'package:demo/floatingball/FloatingballInit.dart';
import 'package:demo/util/sblogger/SbLogger.dart';
import 'package:demo/vc/view/homepage/HomePage.dart';
import 'package:flutter/material.dart';

enum AppInitStatus { ok, exception, initializing }

class AppInitPage extends StatefulWidget {
  const AppInitPage({required this.builder});

  /// [builder] 如果 使用 Widget 而不使用 Widget Function() 的话，Widget 对象在初始化时就会被创建。
  /// 从而会导致 [HomePage] 会先被初始化后才会进行 [AppInitPage] 初始化。
  final Widget Function() builder;

  @override
  _AppInitPageState createState() => _AppInitPageState();
}

class _AppInitPageState extends State<AppInitPage> {
  ///

  late final Future<AppInitStatus> _future = Future<AppInitStatus>(
    () async {
      final SqliteInitResult sqliteInitResult = await SqliteInit().init();
      FloatingBallInit().init(context);
      if (sqliteInitResult == SqliteInitResult.ok) {
        return AppInitStatus.ok;
      } else {
        return AppInitStatus.exception;
      }
    },
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppInitStatus>(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot<AppInitStatus> snapshot) {
        if (snapshot.hasError) {
          sbLogger(message: 'initAll err: ', exception: snapshot.error, stackTrace: snapshot.stackTrace);
          return const Scaffold(
            body: Center(
              child: Text('应用初始化失败！'),
            ),
          );
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Scaffold(
              body: Center(
                child: Text('正在初始化应用中...'),
              ),
            );
          case ConnectionState.done:
            if (snapshot.hasData && snapshot.data == AppInitStatus.ok) {
              return widget.builder();
            } else {
              return const Scaffold(
                body: Center(
                  child: Text('应用初始化失败！'),
                ),
              );
            }
          default:
            return const Scaffold(
              body: Center(
                child: Text('应用初始化失败！'),
              ),
            );
        }
      },
    );
  }
}
