

import 'package:flutter/material.dart';

import 'SbPopResult.dart';
import 'SbRoute.dart';

class SbPopupRouteWidget extends StatefulWidget {
  const SbPopupRouteWidget(this.sbPopupRoute);

  final SbRoute sbPopupRoute;

  @override
  _SbPopupRouteWidgetState createState() => _SbPopupRouteWidgetState();
}

class _SbPopupRouteWidgetState extends State<SbPopupRouteWidget> {
  @override
  void initState() {
    super.initState();
    widget.sbPopupRoute.init();
    widget.sbPopupRoute.context = context;
    widget.sbPopupRoute.toastRouteSetState ??= setState;

    final RenderBox fatherRenderBox =
    widget.sbPopupRoute.fatherContext.findRenderObject()! as RenderBox;
    final Size size = fatherRenderBox.size;
    final Offset offset = fatherRenderBox.localToGlobal(Offset.zero);
    widget.sbPopupRoute.fatherWidgetRect =
        Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height);
    WidgetsBinding.instance!.addPostFrameCallback(
          (Duration timeStamp) {
        widget.sbPopupRoute.initDone();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    widget.sbPopupRoute.buildCallBack();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.topLeft,
          children: <Widget>[
            background(),
            ...widget.sbPopupRoute.body(),
            popWaiting(),
          ],
        ),
      ),
    );
  }

  /// 背景
  Widget background() {
    return Positioned(
      top: 0,
      child: Listener(
        onPointerUp: (_) {
          widget.sbPopupRoute.toPop(
            SbPopResult(
                value: null, popResultSelect: PopResultSelect.clickBackground),
          );
        },
        child: Opacity(
          opacity: widget.sbPopupRoute.backgroundOpacity,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: widget.sbPopupRoute.backgroundColor,
          ),
        ),
      ),
    );
  }

  /// popWaiting
  Widget popWaiting() {
    return Positioned(
      top: 0,
      child: Offstage(
        offstage: !widget.sbPopupRoute.isPopWaiting,
        child: Opacity(
          opacity: 0.5,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            color: Colors.white,
            child: const Text('等待中...'),
          ),
        ),
      ),
    );
  }
}
