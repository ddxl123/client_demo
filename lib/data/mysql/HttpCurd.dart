import 'package:demo/Config.dart';
import 'package:demo/data/model/MToken.dart';
import 'package:demo/data/model/ModelManager.dart';
import 'package:demo/data/mysql/HttpResult.dart';
import 'package:demo/data/mysql/vo/CreateTokenVO.dart';
import 'package:demo/data/mysql/vo/ResponseVOBase.dart';
import 'package:demo/data/sqlite/sqliter/SqliteCurd.dart';
import 'package:demo/util/sblogger/SbLogger.dart';
import 'package:dio/dio.dart';

import 'HttpInit.dart';

class HttpCurd {
  int i = 0;

  /// 不可并发请求标志
  static final Map<String, bool> _sameNotConcurrentMap = <String, bool>{};

  /// 是否处于正在 refresh token 状态
  static bool _isTokenRefreshing = false;

  /// 是否处于正在 get token 状态
  static bool _isTokenCreating = false;

  ///
  ///
  ///
  /// general request
  ///
  /// 调用该函数后，会立即触发 [ sameNotConcurrentMap[sameNotConcurrent] = 1 ]，(非异步触发，即会在函数内的异步操作前被触发)，以供其他请求进行中断。
  ///
  /// - [<T>] 响应的 [data] 类型
  /// - [method] GET POST
  /// - [route] 请求路径, $route eg."api/xxx"
  /// - [data] 请求体。只有在 POST 请求时使用。
  /// - [isAuth] 是否需通过 auth 验证
  /// - [queryParameters] 请求 queryParameters。只有在 GET 请求时使用。
  /// - [resultCallback] 响应结果。[code] 响应码, [data] 响应数据。**注意:返回的结果可以是 Future, 函数内部已嵌套 await**
  /// - [sameNotConcurrent] 相同请求不可并发标记，为 null 时代表不进行标记。**注意:返回的结果可以是 Future, 函数内部已嵌套 await**
  /// - [interruptedCallback] 被中断的回调
  ///   - [GeneralRequestInterruptedStatus]：
  ///     - [isAuth = true] 时：含 [GeneralRequestInterruptedStatus.concurrentBefore]、[GeneralRequestInterruptedStatus.concurrentAfter]、
  ///                             [GeneralRequestInterruptedStatus.accessTokenExpired]、[GeneralRequestInterruptedStatus.localDioError]、
  ///                             [GeneralRequestInterruptedStatus.localUnknownError]
  ///        - 其中 [GeneralRequestInterruptedStatus.accessTokenExpired] 会调用 [sendRefreshTokenRequest] 函数
  ///     - [isAuth = false] 时：含 [GeneralRequestInterruptedStatus.concurrentBefore]、[GeneralRequestInterruptedStatus.localDioError]、
  ///                              [GeneralRequestInterruptedStatus.localUnknownError]
  ///
  /// 向云端修改数据成功，而响应回本地修改 sqlite 数据失败 ———— 该问题会在 [SqliteCurd] 中进行处理。
  ///
  static Future<HttpResult<T>> sendRequest<T extends ResponseVOBase>({
    required String method,
    required String route,
    required bool isAuth,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    required String? sameNotConcurrent,
    required T dataVO,
  }) async {
    try {
      /// 若相同请求被并发
      if (_sameNotConcurrentMap.containsKey(sameNotConcurrent)) {
        return HttpResult<T>.of(HttpResultType.failure, null, null);
      }

      /// 当相同请求未并发时，对当前请求做阻断标记
      if (sameNotConcurrent != null) {
        _sameNotConcurrentMap[sameNotConcurrent] = true;
      }

      sbLogger(message: '$method ' + dio.options.baseUrl + route);

      if (isDev) {
        await Future<void>.delayed(const Duration(seconds: 2));
      }

      /// 给请求头设置 token
      Map<String, dynamic>? headers;
      if (isAuth) {
        final List<MToken> tokens = await ModelManager.queryRowsAsModels(connectTransaction: null, tableName: MToken().tableName);
        if (tokens.isEmpty || tokens.first.get_token == null) {
          //TODO: 这里弹出重新登陆框。
          return HttpResult<T>.of(HttpResultType.failure, null, null);
        }
        headers = <String, dynamic>{'Authorization': 'Bearer ' + tokens.first.get_token!};
      }
      final Response<Map<String, dynamic>> response = await dio.request<Map<String, dynamic>>(
        route,
        data: data,
        queryParameters: queryParameters,
        options: Options(method: method, headers: headers),
      );
      final HttpResult<T> httpResult = HttpResult<T>.from(response, dataVO);
      if (isAuth) {
        // token 验证失败（可能是 token 过期），需重新登陆。
        if (httpResult.code == 1) {
          //TODO: 这里弹出重新登陆框。
          httpResult.httpResultType = HttpResultType.failure;
        }
      }

      return httpResult;
    } catch (e, st) {
      return HttpResult<T>.of(HttpResultType.failure, e, st);
    } finally {
      _sameNotConcurrentMap.remove(sameNotConcurrent);
    }
  }

  ///
  ///
  ///
  /// create token
  ///
  /// 调用该函数后，会立即触发 [ _isTokenCreating = true ]，(非异步触发，即会在函数内的异步操作前被触发)，以供其他请求进行中断。
  ///
  ///  [route]：请求 route
  ///
  ///  [willVerifyData]：将验证的数据，比如 邮箱 + 验证码
  ///
  static Future<HttpResult<CreateTokenVO>> sendRequestForCreateToken({
    required String route,
    required Map<String, dynamic> willVerifyData,
  }) async {
    try {
      if (_isTokenCreating) {
        return HttpResult<CreateTokenVO>.of(HttpResultType.failure, null, null);
      }
      _isTokenCreating = true;

      if (isDev) {
        await Future<void>.delayed(const Duration(seconds: 2));
      }

      sbLogger(message: 'POST ' + dio.options.baseUrl + route);

      final Response<Map<String, dynamic>> response = await dio.request<Map<String, dynamic>>(route, options: Options(method: 'POST'), data: willVerifyData);

      return HttpResult<CreateTokenVO>.from(response, CreateTokenVO());
    } catch (e, st) {
      return HttpResult<CreateTokenVO>.of(HttpResultType.failure, e, st);
    } finally {
      _isTokenCreating = false;
    }
  }

  ///
  ///
  ///
  /// refresh token
  ///
  /// 调用该函数后，会立即触发 [ _isTokenRefreshing = true ]，(非异步触发，即会在函数内的异步操作前被触发)，以供其他请求进行中断。
  ///
  /// 虽然该函数是异步函数，但调用该函数时，无需 await 进行等待，因为会导致调用该函数的异步函数被延迟调用其 whenComplete 。
  ///
  /// - [tokenRefreshSuccessCallback]：token 刷新成功的回调；**注意:返回的结果可以是 Future, 函数内部已嵌套 await**
  /// - [tokenRefreshFailCallback]：token 刷新失败的回调；**注意:返回的结果可以是 Future, 函数内部已嵌套 await**
  ///
  static Future<HttpResult<CreateTokenVO>> sendRefreshTokenRequest() async {
    try {
      if (_isTokenRefreshing) {
        return HttpResult<CreateTokenVO>.of(HttpResultType.failure, null, null);
      }
      _isTokenRefreshing = true;

      sbLogger(message: '正在 refresh token');

      if (isDev) {
        await Future<void>.delayed(const Duration(seconds: 2));
      }

// 从 sqlite 中获取 refresh_token
      final String refreshToken = await Token().getSqliteToken(tokenTypeCode: 1);

      await dio
          .request<Map<String, dynamic>>(
        '/api/refresh_token',
        options: Options(method: 'GET', headers: <String, String>{'Authorization': 'Bearer ' + refreshToken}),
      )
          .then(
        (Response<Map<String, dynamic>> response) async {
          final CodeAndData<Map<String, String>> codeAndData = CodeAndData<Map<String, String>>(response);

          switch (codeAndData.resultCode) {
            case -2:
// 存储响应的 tokens
              await Token().setSqliteToken(
                tokens: codeAndData.resultData,
                success: () async {
                  await tokenRefreshSuccessCallback();
                },
                fail: (int failCode) async {
                  if (failCode == 1) {
                    await tokenRefreshFailCallback(RequestInterruptedType.refreshTokenTokensIsNull);
                  } else {
                    await tokenRefreshFailCallback(RequestInterruptedType.refreshTokenTokensSaveFail);
                  }
                },
              );
              break;
            case -3:
// 刷新 token 失败，可能是过期，或者 refresh_token 值不准确
              await tokenRefreshFailCallback(RequestInterruptedType.refreshTokenRefreshTokenExpired);
              break;
            default:
// 1. 可能是未知code
// 2. code 值可能非int类型，比如null
              await tokenRefreshFailCallback(RequestInterruptedType.refreshTokenCodeUnknown);
          }
        },
      );
    } catch (e) {
      await _catchLocalError(e, tokenRefreshFailCallback);
    } finally {
      _isTokenRefreshing = false;
    }
  }

  ///
  ///
  ///
  /// catch local error
  ///
  /// catchError 需要返回 Future<Null> 类型
  ///
// ignore: prefer_void_to_null
  static Future<Null> _catchLocalError(
    dynamic onError,
    Function interruptedStatusCallback,
  ) async {
    if (onError is DioError) {
// 1.可能本地请求的发送异常
// 2.可能返回的响应码非 200
      dLog(() => '捕获到本地 DioError 异常!', () => onError);
      await interruptedStatusCallback(RequestInterruptedType.localDioError);
    } else if (onError is RequestInterruptedType) {
      dLog(() => '捕获到 RequestInterruptedType 异常!', () => onError);
      await interruptedStatusCallback(RequestInterruptedType.codeAndDataError);
    } else {
      dLog(() => '捕获到本地未知异常!', () => onError);
      await interruptedStatusCallback(RequestInterruptedType.localUnknownError);
    }
  }

  ///
}
