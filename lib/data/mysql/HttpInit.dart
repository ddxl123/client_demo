import 'package:dio/dio.dart';

/// 全局 [dio]
final Dio dio = Dio();

class HttpInit {
  void init() {
    // dio.options.baseUrl = 'http://jysp.free.idcfengye.com/'; // 内网穿透-测试
    dio.options.baseUrl = 'http://192.168.10.10:80/'; // 仅本地
    dio.options.connectTimeout = 30000; // ms
    dio.options.receiveTimeout = 30000; // ms
  }
}
