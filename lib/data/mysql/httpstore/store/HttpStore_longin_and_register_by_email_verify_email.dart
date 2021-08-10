// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names

import 'package:demo/data/mysql/http/HttpPath.dart';
import 'package:demo/data/mysql/httpstore/base/HttpRequest.dart';
import 'package:demo/data/mysql/httpstore/base/HttpResponse.dart';

import '../base/HttpStore.dart';

class HttpStore_longin_and_register_by_email_verify_email extends HttpStore_POST {
  HttpStore_longin_and_register_by_email_verify_email(
    RequestDataVO requestDataVO,
  ) : super(
          HttpPath.NO_JWT + '/login_and_register_by_email/verify_email',
          requestDataVO,
          ResponseCodeCollect_LARBEVE(),
          ResponseNullDataVO(),
        );
}

class RequestDataVO_LARBEVE extends RequestDataVO {
  RequestDataVO_LARBEVE({required this.email, required this.code});

  final KeyValue<String> email;

  final KeyValue<int> code;

  @override
  List<KeyValue<Object?>> get keyValues => <KeyValue<Object?>>[email, code];
}

class ResponseCodeCollect_LARBEVE extends ResponseCodeCollect {
  /// 注册成功。
  final int C1_02_02 = 1010202;

  /// 登陆成功。
  final int C1_02_05 = 1010205;
}
