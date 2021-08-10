// ignore_for_file: camel_case_types

import 'package:demo/data/model/MToken.dart';
import 'package:demo/data/model/ModelManager.dart';
import 'package:demo/data/mysql/http/HttpPath.dart';
import 'package:demo/data/mysql/httpstore/base/HttpResponse.dart';
import 'package:dio/dio.dart';

import 'HttpRequest.dart';

abstract class HttpStore {
  late final HttpRequest httpRequest;
  late final HttpResponse httpResponse;

  /// 直接取消。
  HttpStore setCancel({required String description, required Object? exception, required StackTrace? stackTrace}) {
    httpResponse.setCancel(description, exception, stackTrace);
    return this;
  }

  /// 直接通过。
  HttpStore setPass(Response<Map<String, dynamic>> response) {
    httpResponse.setPass(response);
    return this;
  }

  Future<void> requestCheck() async {
    final String must = httpRequest.path.split('/')[1];
    if (must == HttpPath.JWT) {
      final List<MToken> tokens = await ModelManager.queryRowsAsModels(connectTransaction: null, tableName: MToken().tableName);
      httpRequest.requestHeaders = <String, dynamic>{'Authorization': 'Bearer ' + (tokens.isEmpty ? '' : (tokens.first.get_token ?? ''))};
    } else if (must == HttpPath.NO_JWT) {
    } else {
      throw 'Path is irregular! "${httpRequest.path}"';
    }
  }
}

abstract class HttpStore_GET extends HttpStore {
  HttpStore_GET(
    String path,
    RequestParamsVO requestParamsVO,
    ResponseCodeCollect responseCodeCollect,
    ResponseDataVO responseDataVO,
  ) {
    httpRequest = HttpRequest(
      method: 'GET',
      path: path,
      requestHeaders: null,
      requestParamsVO: requestParamsVO,
      requestDataVO: null,
    );
    httpResponse = HttpResponse(
      responseCodeCollect: responseCodeCollect,
      responseDataVO: responseDataVO,
    );
  }
}

abstract class HttpStore_POST extends HttpStore {
  HttpStore_POST(
    String path,
    RequestDataVO requestDataVO,
    ResponseCodeCollect responseCodeCollect,
    ResponseDataVO responseDataVO,
  ) {
    httpRequest = HttpRequest(
      method: 'POST',
      path: path,
      requestHeaders: null,
      requestParamsVO: null,
      requestDataVO: requestDataVO,
    );
    httpResponse = HttpResponse(
      responseCodeCollect: responseCodeCollect,
      responseDataVO: responseDataVO,
    );
  }
}

class HttpStore_Catch extends HttpStore {
  HttpStore_Catch() {
    httpRequest = HttpRequest(
      method: '-',
      path: '-',
      requestHeaders: null,
      requestParamsVO: null,
      requestDataVO: null,
    );
    httpResponse = HttpResponse(
      responseCodeCollect: null,
      responseDataVO: null,
    );
  }
}

// ========================================================================================

// abstract class HttpStoreBase_create_token extends HttpStoreBase {
//   HttpStoreBase_create_token(RequestDataVOBase getRequestDataVO) : super(getRequestDataVO);
//
//   /// 邮箱验证 --- 注册成功！
//   final int C1_02_02 = 1010202;
//
//   /// 邮箱验证 --- 登陆成功！
//   final int C1_02_05 = 1010205;
// }
