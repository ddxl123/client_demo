import 'dart:async';

import 'package:demo/data/mysql/http/HttpCurd.dart';
import 'package:demo/data/mysql/http/HttpPath.dart';
import 'package:demo/data/mysql/http/HttpResult.dart';
import 'package:demo/data/mysql/responsedatavo/NullDataVO.dart';
import 'package:demo/data/mysql/vo/NullDataVO.dart';
import 'package:demo/global/Global.dart';
import 'package:demo/util/sblogger/SbLogger.dart';
import 'package:demo/util/sbroundedbox/SbRoundedBox.dart';
import 'package:demo/util/sbroute/SbPopResult.dart';
import 'package:demo/util/sbroute/SbRoute.dart';
import 'package:demo/util/sheetroute/Helper.dart';
import 'package:flutter/material.dart';

class LoginPage extends SbRoute {
  TextEditingController emailTextEditingController = TextEditingController(text: '1033839760@qq.com');
  TextEditingController codeTextEditingController = TextEditingController();

  Timer? timer;
  int time = 30;
  String text = '发送';

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
                _sendEmailButton(),
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

  Widget _sendEmailButton() {
    return StatefulInitBuilder(
      init: (StatefulInitBuilderState state) {},
      builder: (StatefulInitBuilderState state) {
        return TextButton(
          child: Text(text),
          onPressed: () async {
            if (timer == null) {
              time = 10;
              text = time.toString() + 's';
              state.refresh();
              timer = Timer.periodic(
                const Duration(seconds: 1),
                (Timer t) {
                  if (time == 0) {
                    timer?.cancel();
                    timer = null;
                    text = '重新发送';
                    state.refresh();
                    return;
                  }
                  time -= 1;
                  text = time.toString() + 's';
                  state.refresh();
                },
              );
              final HttpResult<HttpStore_LONGIN_AND_REGISTER_BY_EMAIL_SEND_EMAIL, NullDataVO> httpResult = await HttpCurd.sendRequest(
                method: 'POST',
                httpPath: HttpStore_LONGIN_AND_REGISTER_BY_EMAIL_SEND_EMAIL(),
                getRequestDataVO: ,
                requestDataVO: <String, dynamic>{},
                queryParameters: null,
                headers: null,
                sameNotConcurrent: 'sendEmail',
                responseDataVO: NullDataVO(),
              );
              await httpResult.handle(
                doCancel: (HttpResult<HttpStore_LONGIN_AND_REGISTER_BY_EMAIL_SEND_EMAIL, NullDataVO> ht) async {
                  timer?.cancel();
                  timer = null;
                  text = '重新发送';
                  state.refresh();
                  SbLogger(
                    code: ht.getCode,
                    viewMessage: ht.getViewMessage,
                    data: null,
                    description: ht.getDescription,
                    exception: ht.getException,
                    stackTrace: ht.getStackTrace,
                  );
                },
                doContinue: (HttpResult<HttpStore_LONGIN_AND_REGISTER_BY_EMAIL_SEND_EMAIL, NullDataVO> ht) async {
                  // 发生成功。
                  if (ht.getCode == ht.getHttpPath.C1_01_02) {
                    SbLogger(
                      code: null,
                      viewMessage: ht.getViewMessage,
                      data: null,
                      description: ht.getDescription,
                      exception: null,
                      stackTrace: null,
                    );
                    return true;
                  }
                  return false;
                },
              );
            }
          },
        );
      },
    );
  }

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
            HttpCurd.sendRequestForCreateToken(
              httpPath: HttpStore_LONGIN_AND_REGISTER_BY_EMAIL_VERIFY_EMAIL(),
              getRequestDataVO: <String, dynamic>{

              },
            );
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
    return await quickWhenPop(popResult, (SbPopResult quickPopResult) async => false);
  }

  @override
  bool whenException(Object? exception, StackTrace? stackTrace) {
    SbLogger.debug(viewMessage: 'err: ', exception: exception, stackTrace: stackTrace);
    return false;
  }
}
