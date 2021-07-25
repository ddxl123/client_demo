import 'package:demo/global/Global.dart';
import 'package:demo/util/sblogger/SbLogger.dart';
import 'package:demo/util/sbroundedbox/SbRoundedBox.dart';
import 'package:demo/util/sbroute/SbPopResult.dart';
import 'package:demo/util/sbroute/SbRoute.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends SbRoute {
  TextEditingController emailTextEditingController = TextEditingController(text: '1033839760@qq.com');
  TextEditingController codeTextEditingController = TextEditingController();

  @override
  List<Widget> body() {
    return <Widget>[
      SbRoundedBox(
        width: screenSize.width * 4 / 5,
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
        children: <Widget>[
          const Flexible(
            child: Text(
              '登陆/注册',
              style: TextStyle(fontSize: 18),
            ),
          ),
          _emailInputField(),
          const Flexible(child: SizedBox(height: 10)),
          Flexible(
            child: Row(
              children: <Widget>[
                _codeInputField(),
                // _sendEmailButton(),
              ],
            ),
          ),
          const Flexible(child: SizedBox(height: 10)),
          _verifyEmailButton(),
        ],
      ),
    ];
  }

  Widget _emailInputField() {
    return Flexible(
      child: TextField(
        controller: emailTextEditingController,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.zero,
          icon: Icon(Icons.person),
          labelText: '邮箱',
        ),
        minLines: 1,
        maxLines: 1,
      ),
    );
  }

  Widget _codeInputField() {
    return Expanded(
      child: TextField(
        controller: codeTextEditingController,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.zero,
          icon: Icon(Icons.lock),
          labelText: '验证码',
        ),
        minLines: 1,
        maxLines: 1,
      ),
    );
  }

  // Widget _sendEmailButton() {
  //   return RebuildHandleWidget<SendEmailButtonHandlerEnum>(
  //     rebuildHandler:
  //         context.read<LoginPageController>().sendEmailButtonRebuildHandler,
  //     builder: (RebuildHandler<SendEmailButtonHandlerEnum> handler) {
  //       if (handler.handleCode == SendEmailButtonHandlerEnum.countdown) {
  //         // 倒计时状态
  //         handler.state['banOnPressed'] = true;
  //         handler.state['time'] ??= 10;
  //         handler.state['text'] = "${handler.state["time"]} s";
  //         handler.state['timer'] ??= Timer.periodic(
  //           const Duration(seconds: 1),
  //           (Timer timer) {
  //             if (handler.state['time'] == 0) {
  //               (handler.state['timer'] as Timer).cancel();
  //               handler.rebuildHandle(SendEmailButtonHandlerEnum.unSent, true);
  //             } else {
  //               handler.state['time'] -= 1;
  //               handler.rebuildHandle(SendEmailButtonHandlerEnum.countdown);
  //             }
  //           },
  //         );
  //       } else if (handler.handleCode == SendEmailButtonHandlerEnum.unSent) {
  //         // 未发送状态
  //         handler.state['timer']?.cancel();
  //         handler.state.clear();
  //         handler.state['banOnPressed'] = false;
  //         handler.state['text'] = '发送验证码';
  //       }
  //
  //       return TextButton(
  //         style: ButtonStyle(
  //           side: MaterialStateProperty.all(
  //               const BorderSide(color: Colors.green)),
  //         ),
  //         child: Text(handler.state['text'] as String),
  //         onPressed: () {
  //           if (handler.state['banOnPressed'] == true) {
  //             dLog(() => 'banOnPressed');
  //             return;
  //           }
  //           handler.rebuildHandle(SendEmailButtonHandlerEnum.countdown);
  //           context.read<LoginPageController>().sendEmailRequest(
  //                 handler: handler,
  //                 emailTextEditingController: context
  //                     .read<LoginPageController>()
  //                     .emailTextEditingController,
  //               );
  //         },
  //       );
  //     },
  //   );
  // }

  Widget _verifyEmailButton() {
    return Flexible(
      child: Container(
        width: double.maxFinite,
        child: TextButton(
          style: ButtonStyle(
            side: MaterialStateProperty.all(const BorderSide(color: Colors.green)),
          ),
          child: const Text('登陆/注册'),
          onPressed: () {
            // context.read<LoginPageController>().verifyEmailRequest(
            //       qqEmailTextEditingController: context
            //           .read<LoginPageController>()
            //           .emailTextEditingController,
            //       codeTextEditingController: context
            //           .read<LoginPageController>()
            //           .codeTextEditingController,
            //     );
          },
        ),
      ),
    );
  }

  @override
  Future<bool> whenPop(SbPopResult? popResult) async {
    if (popResult == null) {
      return true;
    }
    if (popResult.popResultSelect == PopResultSelect.clickBackground) {
      return true;
    } else {
      return false;
    }
  }

  @override
  bool whenException(Object exception, StackTrace stackTrace) {
    sbLogger(message: 'err: ', exception: exception, stackTrace: stackTrace);
    return false;
  }
}
