import 'dart:convert';
import 'dart:developer';

enum LogType {
  /// 仅土司。
  toast,

  /// 仅调试。
  debug,

  /// 仅记录。
  record,

  /// 全部。
  all,
}

///
///
///
/// 日志记录。
class Record {
  Record({
    this.level = LogType.all,
    this.code,
    this.message,
    this.description,
    this.exception,
    this.stackTrace,
  });

  LogType level;
  int? code;
  String? message;
  String? description;
  Object? exception;
  StackTrace? stackTrace;
}

///
/// 调试打印输出。
///
/// [message] 消息。
///
/// [indent] Map 或 List，并对其格式化。
///
/// [exception] 需要输出的异常。
///
/// [stackTrace] 异常捕获的第二个参数。
class Debug {
  Debug({
    this.message,
    this.indent,
    this.exception,
    this.stackTrace,
  }) {}

  Object? message;
  Object? indent;
  Object? exception;
  StackTrace? stackTrace;
}

class SbLogger {
  ///

  SbLogger({
    required this.code,
    required this.viewMessage,
    required this.data,
    required this.description,
    required this.exception,
    required this.stackTrace,
  }) {
    _debug();
    _toast();
    _record();
  }

  /// 信息码。
  int? code;

  /// 显示在 toast 的 【文本消息】，不包含 [code]。
  String? viewMessage;

  /// 描述。
  String? description;

  /// 数据。[Map]、[List] 会被自动缩进。
  Object? data;

  Object? exception;
  StackTrace? stackTrace;

  void _debug() {
    // 当 code 不为空时，若 viewMessage 为空，则违背了【错误信息+错误码】的意图。
    if (code != null && viewMessage == null) {
      viewMessage = '无信息';
    }

    log('code: ${code ?? ''}');
    log('toast: ${viewMessage ?? ''}');
    log('description: ${description ?? ''}');
    try {
      log('data: \n${const JsonEncoder.withIndent('  ').convert(data)}');
    } catch (e) {
      log('data: $data');
    }
    log('exception: ', error: exception);

    try {
      if (stackTrace != null) {
        log('', stackTrace: stackTrace);
      } else {
        final String st = StackTrace.current.toString();
        final String package = '(package:' + st.split('(package:')[2].split(')')[0] + ')';
        log(package);
      }
    } catch (e, st) {
      log('stackTrace err: ', error: e, stackTrace: st);
    }
  }

  void _toast() {}

  void _record() {}
}
