import 'package:demo/data/mysql/http/HttpPath.dart';
import 'package:dio/dio.dart';

/// 全局 [dio]
final Dio dio = Dio();

class HttpInit {
  void init() {
    // dio.options.baseUrl = HttpPath.BASE_PATH_GLOBAL; // 内网穿透-测试
    dio.options.baseUrl = HttpPath.BASE_PATH_LOCAL; // 仅本地
    dio.options.connectTimeout = 30000; // ms
    dio.options.receiveTimeout = 30000; // ms
  }
}
