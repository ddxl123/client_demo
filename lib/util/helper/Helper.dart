// import 'package:demo/util/logger/SbLogger.dart';
// import 'package:flutter/material.dart';
// import 'package:uuid/uuid.dart';
//
// enum Compare { frontBig, backBig, equal }
//
// /// 若 [front] 大于 [back]，
// /// - 则返回 [Compare.frontBig]，
// ///
// /// 若 [front] 小于 [back]，
// /// - 则返回 [Compare.backBig]，
// ///
// /// 若 [front] 等于 [back]，
// /// - 则返回 [Compare.equal]，
// Compare compare(int front, int back) {
//   if (front > back) {
//     return Compare.frontBig;
//   } else if (front < back) {
//     return Compare.backBig;
//   } else {
//     return Compare.equal;
//   }
// }
//
// /// 将 '111,222' 字符串转化成 Offset(111,222)
// ///
// /// 若解析错误，则返回 [Offset.zero]
// Offset stringToOffset(String? offsetStr) {
//   try {
//     final List<String> sp = offsetStr!.split(',');
//     return Offset(double.parse(sp[0]), double.parse(sp[1]));
//   } catch (e) {
//     sbLogger(message: 'Parse position err: ', exception: e);
//     return Offset.zero;
//   }
// }
//
// /// 生成一个 UUID
// String createUUID() {
//   return const Uuid().v4();
// }
//
// /// 生成当前时间戳(ms)
// int createCurrentTimestamp() {
//   return DateTime.now().millisecondsSinceEpoch;
// }
