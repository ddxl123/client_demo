import 'dart:async';

import 'package:demo/data/mysql/http/HttpCurd.dart';
import 'package:demo/data/mysql/httpstore/base/HttpRequest.dart';
import 'package:demo/data/mysql/httpstore/base/HttpResponse.dart';
import 'package:demo/data/mysql/httpstore/store/HttpStore_login_and_register_by_email_send_email.dart';
import 'package:demo/data/mysql/httpstore/store/HttpStore_login_and_register_by_email_verify_email.dart';
import 'package:demo/data/sqlite/mmodel/MToken.dart';
import 'package:demo/data/sqlite/mmodel/MUser.dart';
import 'package:demo/data/sqlite/sqliter/OpenSqlite.dart';
import 'package:demo/global/Global.dart';
import 'package:demo/util/SbHelper.dart';
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

              final HttpStore_login_and_register_by_email_send_email httpStore = await HttpCurd.sendRequest(
                getHttpStore: () => HttpStore_login_and_register_by_email_send_email(
                  requestDataVO_LARBESE: RequestDataVO_LARBESE(
                    email: KeyValue<String>(MUser().email, emailTextEditingController.text),
                  ),
                ),
                sameNotConcurrent: null,
                isBanAllOtherRequest: true,
              );
              httpStore.httpResponse.handle(
                doContinue: (HttpResponse<ResponseCodeCollect_LARBESE, ResponseNullDataVO> hr) async {
                  // 发生成功。
                  if (hr.code == hr.responseCodeCollect.C1_01_02) {
                    SbLogger(
                      code: null,
                      viewMessage: hr.viewMessage,
                      data: null,
                      description: hr.description,
                      exception: null,
                      stackTrace: null,
                    );
                    return true;
                  }
                  return false;
                },
                doCancel: (HttpResponse<ResponseCodeCollect_LARBESE, ResponseNullDataVO> hr) async {
                  timer?.cancel();
                  timer = null;
                  text = '重新发送';
                  state.refresh();
                  SbLogger(
                    code: hr.code,
                    viewMessage: hr.viewMessage,
                    data: null,
                    description: hr.description,
                    exception: hr.exception,
                    stackTrace: hr.stackTrace,
                  );
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
          onPressed: () async {
            final HttpStore_login_and_register_by_email_verify_email httpStore = await HttpCurd.sendRequest(
              getHttpStore: () => HttpStore_login_and_register_by_email_verify_email(
                requestDataVO_LARBEVE: RequestDataVO_LARBEVE(
                  email: KeyValue<String>(MUser().email, emailTextEditingController.text),
                  code: KeyValue<int>('code', int.parse(codeTextEditingController.text)),
                ),
              ),
              sameNotConcurrent: null,
              isBanAllOtherRequest: true,
            );
            await httpStore.httpResponse.handle(
              doCancel: (HttpResponse<ResponseCodeCollect_LARBEVE, ResponseDataVO_LARBEVE> hr) async {
                SbLogger(
                  code: hr.code,
                  viewMessage: hr.viewMessage,
                  data: null,
                  description: hr.description,
                  exception: hr.exception,
                  stackTrace: hr.stackTrace,
                );
              },
              doContinue: (HttpResponse<ResponseCodeCollect_LARBEVE, ResponseDataVO_LARBEVE> hr) async {
                if (hr.code == hr.responseCodeCollect.C1_02_02 || hr.code == hr.responseCodeCollect.C1_02_05) {
                  // 云端 token 生成成功，存储至本地。
                  final MToken newToken = MToken.createModel(
                    id: null,
                    aiid: null,
                    uuid: null,
                    created_at: SbHelper().newTimestamp,
                    updated_at: SbHelper().newTimestamp,
                    // 无论 token 值是否有问题，都进行存储。
                    token: hr.responseDataVO.token,
                  );

                  await db.delete(MToken().tableName);
                  await db.insert(newToken.tableName, newToken.getRowJson);

                  SbLogger(
                    code: null,
                    viewMessage: hr.viewMessage,
                    data: null,
                    description: null,
                    exception: null,
                    stackTrace: null,
                  );
                  return true;
                }
                return false;
              },
            );
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
    SbLogger(code: null, viewMessage: null, data: null, description: null, exception: exception, stackTrace: stackTrace);
    return false;
  }
}
