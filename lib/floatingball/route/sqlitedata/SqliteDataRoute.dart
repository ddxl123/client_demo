import 'dart:ui';

import 'package:demo/data/sqlite/sqliter/SqliteTool.dart';
import 'package:demo/floatingball/route/sqlitedata/TableDataRoute.dart';
import 'package:demo/util/sblogger/SbLogger.dart';
import 'package:demo/util/sbroundedbox/SbRoundedBox.dart';
import 'package:demo/util/sbroute/SbPopResult.dart';
import 'package:demo/util/sbroute/SbRoute.dart';
import 'package:flutter/material.dart';

class SqliteDataRoute extends SbRoute {
  @override
  Color get backgroundColor => Colors.pink;

  @override
  // TODO: implement backgroundOpacity
  double get backgroundOpacity => 0;

  late final Future<List<String>> _future = Future<List<String>>(() async {
    return await SqliteTool().getAllTableNames();
  });

  Widget _builder(BuildContext context, AsyncSnapshot<List<String>> snapshot) {
    Widget sbRoundedBox({required List<Widget> children}) {
      return SbRoundedBox(
        width: MediaQueryData.fromWindow(window).size.width * 2 / 3,
        height: MediaQueryData.fromWindow(window).size.height * 2 / 3,
        children: children,
      );
    }

    if (!snapshot.hasData || snapshot.hasError) {
      sbLogger(message: 'err: ', exception: snapshot.error, stackTrace: snapshot.stackTrace);
      return sbRoundedBox(
        children: const <Widget>[
          Text('获取失败'),
        ],
      );
    }
    switch (snapshot.connectionState) {
      case ConnectionState.waiting:
        return sbRoundedBox(
          children: const <Widget>[
            Text('正在获取中...'),
          ],
        );
      case ConnectionState.done:
        return sbRoundedBox(
          children: <Widget>[
            for (int i = 0; i < snapshot.data!.length; i++)
              //
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextButton(
                      child: Text(snapshot.data![i]),
                      onPressed: () {
                        Navigator.push(context, TableDataRoute(currentTableName: snapshot.data![i]));
                      },
                    ),
                  ),
                ],
              ),
          ],
        );
      default:
        return sbRoundedBox(
          children: const <Widget>[
            Text('unknown snapshot'),
          ],
        );
    }
  }

  @override
  List<Widget> body() {
    return <Positioned>[
      Positioned(
        child: Center(
          child: FutureBuilder<List<String>>(
            initialData: const <String>[],
            future: _future,
            builder: _builder,
          ),
        ),
      ),
    ];
  }

  @override
  Future<bool> whenPop(SbPopResult? popResult) async {
    if (popResult == null) {
      return true;
    }
    if (popResult.popResultSelect == PopResultSelect.clickBackground) {
      return true;
    }
    return false;
  }

  @override
  bool whenException(Object exception, StackTrace stackTrace) {
    sbLogger(message: 'err: ', exception: exception, stackTrace: stackTrace);
    return false;
  }
}
