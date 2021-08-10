// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names

import 'package:demo/data/mysql/http/HttpPath.dart';
import 'package:demo/data/mysql/httpstore/base/HttpRequest.dart';
import 'package:demo/data/mysql/httpstore/base/HttpResponse.dart';

import '../base/HttpStore.dart';

class HttpStore_longin_and_register_by_email_send_email extends HttpStore_POST {
  HttpStore_longin_and_register_by_email_send_email(
    RequestDataVO_LARBESE requestDataVO_LARBESE,
  ) : super(
          HttpPath.NO_JWT + '/login_and_register_by_email/send_email',
          requestDataVO_LARBESE,
          ResponseCodeCollect_LARBESE(),
          ResponseNullDataVO(),
        );
}

class RequestDataVO_LARBESE extends RequestDataVO {
  RequestDataVO_LARBESE({required this.email});

  final KeyValue<String> email;

  @override
  List<KeyValue<Object?>> get keyValues => <KeyValue<Object?>>[email];
}

class ResponseCodeCollect_LARBESE extends ResponseCodeCollect {
  /// 邮箱已发送, 请注意查收!
  final int C1_01_02 = 1010102;
}
