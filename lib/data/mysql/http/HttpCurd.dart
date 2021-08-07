// ignore_for_file: avoid_classes_with_only_static_members
import 'package:demo/Config.dart';
import 'package:demo/data/model/MToken.dart';
import 'package:demo/data/model/ModelManager.dart';
import 'package:demo/data/mysql/http/HttpPath.dart';
import 'package:demo/data/mysql/http/HttpResult.dart';
import 'package:demo/data/mysql/vo/CreateTokenVO.dart';
import 'package:demo/data/mysql/vo/ResponseVOBase.dart';
import 'package:demo/data/sqlite/sqliter/OpenSqlite.dart';
import 'package:demo/data/sqlite/sqliter/SqliteCurd.dart';
import 'package:demo/util/SbHelper.dart';
import 'package:demo/util/sblogger/SbLogger.dart';
import 'package:dio/dio.dart';

import 'HttpInit.dart';

class HttpCurd {
  /// 【常规】请求的不可并发请求标志
  static final Map<String, bool> _sameNotConcurrentMap = <String, bool>{};

  /// 是否禁止所有请求。
  static bool _isBanAllRequest = false;

  ///
  ///
  ///
  /// general request
  ///
  /// [T] 响应的 [data] VO 模型。
  ///
  /// [method] GET POST
  ///
  /// [path] 请求路径, 不包含 base path。
  ///
  /// [data] 请求体。只有在 POST 请求时使用。
  ///
  /// [queryParameters] 请求 queryParameters。只有在 GET 请求时使用。
  ///
  /// [sameNotConcurrent] 不可并发标记。多个请求（可相同可不同），具有相同标记的请求不可并发。为 null 时代表不进行标记（即可并发）。
  ///
  /// [dataVO] 响应数据的 data VO 模型。
  ///
  /// [isBanAllOtherRequest] 若为 true，则其他请求全部禁止，只有当前请求继续直到当前请求结束。
  ///   - 若为 true，但同时存在其他请求，则当前请求也会失败。
  ///
  /// 向云端修改数据成功，而响应回本地修改 sqlite 数据失败 ———— 该问题会在 [SqliteCurd] 中进行处理。
  ///
  static Future<HttpResult<T>> sendRequest<T extends ResponseVOBase>({
    required String method,
    required String path,
    required Map<String, dynamic>? data,
    required Map<String, dynamic>? queryParameters,
    required Map<String, dynamic>? headers,
    required String? sameNotConcurrent,
    required T dataVO,
    bool isBanAllOtherRequest = false,
  }) async {
    try {
      if (_isBanAllRequest) {
        return HttpResult<T>.failure(null, null);
      }

      if (isBanAllOtherRequest) {
        // 若存在任意请求，则当前请求触发失败。
        if (_sameNotConcurrentMap.isNotEmpty) {
          return HttpResult<T>.failure(null, null);
        }
        _isBanAllRequest = true;
      }

      if (sameNotConcurrent != null) {
        /// 若相同请求被并发
        if (_sameNotConcurrentMap.containsKey(sameNotConcurrent)) {
          return HttpResult<T>.failure(null, null);
        }

        /// 当相同请求未并发时，对当前请求做阻断标记
        _sameNotConcurrentMap[sameNotConcurrent] = true;
      }

      sbLogger(message: '$method ' + dio.options.baseUrl + path);

      if (isDev) {
        await Future<void>.delayed(const Duration(seconds: 2));
      }

      final String must = path.split('/')[1];
      final bool isAuth;
      if (must == 'jwt') {
        isAuth = true;
      } else if (must == 'no_jwt') {
        isAuth = false;
      } else {
        throw 'Path is irregular! "$path"';
      }

      /// 给请求头设置 token
      Map<String, dynamic>? authHeaders;
      if (isAuth) {
        final List<MToken> tokens = await ModelManager.queryRowsAsModels(connectTransaction: null, tableName: MToken().tableName);
        authHeaders = <String, dynamic>{'Authorization': 'Bearer ' + (tokens.isEmpty ? '' : (tokens.first.get_token ?? ''))};
      }

      final Response<Map<String, dynamic>> response = await dio.request<Map<String, dynamic>>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(method: method, headers: headers ?? authHeaders),
      );
      final HttpResult<T> httpResult = HttpResult<T>.from(response, dataVO);

      if (isAuth) {
        if (httpResult.httpResultType == HttpResultType.success) {
          // token 验证失败（可能是 token 过期），需重新登陆。
          if (httpResult.code == 10501 || httpResult.code == 10502 || httpResult.code == 10503 || httpResult.code == 10504) {
            //TODO: 这里弹出重新登陆框。
            httpResult.httpResultType = HttpResultType.failure;
          }
        }
      }

      _sameNotConcurrentMap.remove(sameNotConcurrent);
      _isBanAllRequest = false;
      return httpResult;
    } catch (e, st) {
      _sameNotConcurrentMap.remove(sameNotConcurrent);
      _isBanAllRequest = false;
      return HttpResult<T>.failure(e, st);
    }
  }

  ///
  ///
  ///
  ///
  ///
  static Future<HttpResult<CreateTokenVO>> sendRequestForCreateToken({
    required String path,
    required Map<String, dynamic>? data,
  }) async {
    try {
      sbLogger(message: 'POST ' + dio.options.baseUrl + path);

      if (isDev) {
        await Future<void>.delayed(const Duration(seconds: 2));
      }

      final HttpResult<CreateTokenVO> httpResult = await sendRequest(
        method: 'POST',
        path: '',
        data: data,
        queryParameters: null,
        sameNotConcurrent: null,
        dataVO: CreateTokenVO(),
        isBanAllOtherRequest: true,
        headers: null,
      );

      if (httpResult.httpResultType == HttpResultType.success) {
        if (httpResult.code == 1) {
          // 云端 token 生成成功，存储至本地。
          final MToken newToken = MToken.createModel(
            id: null,
            aiid: null,
            uuid: null,
            created_at: SbHelper().newTimestamp,
            updated_at: SbHelper().newTimestamp,
            // 无论 token 值是否有问题，都进行存储。
            token: httpResult.dataVO.emailToken,
          );

          await db.delete(MToken().tableName);
          await db.insert(newToken.tableName, newToken.getRowJson);
        }
      }

      return httpResult;
    } catch (e, st) {
      return HttpResult<CreateTokenVO>.failure(e, st);
    }
  }

  ///
  ///
  ///
  ///
  ///
  static Future<HttpResult<CreateTokenVO>> sendRequestForRefreshToken() async {
    try {
      sbLogger(message: 'GET ' + dio.options.baseUrl + HttpPath.REFRESH_TOKEN);

      if (isDev) {
        await Future<void>.delayed(const Duration(seconds: 2));
      }

      final List<MToken> tokens = await ModelManager.queryRowsAsModels(connectTransaction: null, tableName: MToken().tableName);

      final Map<String, String> headers = <String, String>{'Authorization': 'Bearer ' + (tokens.isEmpty ? '' : (tokens.first.get_token ?? ''))};

      final HttpResult<CreateTokenVO> httpResult = await sendRequest(
        method: 'GET',
        path: HttpPath.REFRESH_TOKEN,
        headers: headers,
        data: null,
        queryParameters: null,
        sameNotConcurrent: null,
        dataVO: CreateTokenVO(),
        isBanAllOtherRequest: true,
      );

      if (httpResult.httpResultType == HttpResultType.success) {
        if (httpResult.code == 1) {
          // 云端 token 生成成功，存储至本地。
          final MToken newToken = MToken.createModel(
            id: null,
            aiid: null,
            uuid: null,
            created_at: SbHelper().newTimestamp,
            updated_at: SbHelper().newTimestamp,
            // 无论 token 值是否有问题，都进行存储。
            token: httpResult.dataVO.emailToken,
          );

          await db.delete(MToken().tableName);
          await db.insert(newToken.tableName, newToken.getRowJson);
        }
      }

      return httpResult;
    } catch (e, st) {
      return HttpResult<CreateTokenVO>.failure(e, st);
    }
  }

  ///
}
