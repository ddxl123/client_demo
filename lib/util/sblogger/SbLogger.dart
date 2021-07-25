import 'dart:async';
import 'dart:convert';
import 'dart:developer';

/// [message] 消息。
/// [indent] Map 或 List，并对其格式化。
/// [exception] 需要输出的异常。
/// [stackTrace] 异常捕获的第二个参数。
Future<void> sbLogger({
  String? message,
  Object? indent,
  Object? exception,
  StackTrace? stackTrace,
}) async {
  final String st = StackTrace.current.toString();
  final String package = '(package:' + st.split('(package:')[2].split(')')[0] + ')';

  final String messageValue = message ?? '';
  final String indentValue = indent == null ? '' : '\n' + const JsonEncoder.withIndent('  ').convert(indent);
  log('> ' + messageValue + indentValue, error: exception);
  if (stackTrace != null) {
    log('', stackTrace: stackTrace);
  } else {
    log(package);
  }
}
