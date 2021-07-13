import 'dart:async';
import 'dart:convert';
import 'dart:developer';

/// [message] 消息。
/// [indent] Map 或 List，并对其格式化。
/// [exception] 需要输出的异常。
Future<void> sbLogger({
  String? message,
  Object? indent,
  Object? exception,
}) async {
  final String st = StackTrace.current.toString();
  final String package = '(package:' + st.split('(package:')[2].split(')')[0] + ')';
  log(
    message == null
        ? '>'
        : '>$message' +
            (indent == null
                ? ''
                : ('\n' + const JsonEncoder.withIndent('  ').convert(indent))) +
            '\n' +
            package,
    error: exception,
  );
}
