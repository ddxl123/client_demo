import 'package:demo/data/mysql/vo/ResponseVOBase.dart';
import 'package:dio/dio.dart';

enum HttpResultType {
  success,
  failure,
}

class HttpResult<T extends ResponseVOBase> {
  HttpResult.failure(this.exception, this.stackTrace) {
    httpResultType = HttpResultType.failure;
  }

  HttpResult.from(Response<Map<String, dynamic>> response, this.dataVO) {
    try {
      if (response.data == null) {
        exception = Exception('response.data is null');
        httpResultType = HttpResultType.failure;
        return;
      }

      headers = response.headers;

      if (response.data!['code'] == null) {
        exception = Exception('code is null');
        httpResultType = HttpResultType.failure;
        return;
      }

      message = response.data!['message'] as String;

      if (response.data!['data'] == null) {
        httpResultType = HttpResultType.success;
        return;
      }

      dataVO.from(response.data!['data'] as Map<String, dynamic>);
      httpResultType = HttpResultType.success;
    } catch (e, st) {
      exception = e;
      stackTrace = st;
      httpResultType = HttpResultType.failure;
    }
  }

  /// 当 [HttpResultType.failure] 时，
  late HttpResultType httpResultType;

  /// 只有 [HttpResultType.success] 才能调用 [code]。
  late final int code;

  /// 要显示在 toast 上的消息。
  String? message;

  /// 当 [code] 代表为云端异常时，响应的数据为 null。但该 [dataVO] 成员并不为空，因为被赋值为对象，而其对象内部的成员并未进行初始化过（若引用内部成员会报错）。
  ///
  /// 当使用 [HttpResult.failure] 进行构造对象时，[dataVO]、[code] 和 [message] 均未被初始化。
  late final T dataVO;

  late final Headers headers;

  late final Object? exception;
  late final StackTrace? stackTrace;
}
