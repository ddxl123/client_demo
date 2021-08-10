// ignore_for_file: avoid_classes_with_only_static_members
import 'package:demo/Config.dart';
import 'package:demo/data/model/MToken.dart';
import 'package:demo/data/model/ModelManager.dart';
import 'package:demo/data/mysql/http/HttpPath.dart';
import 'package:demo/data/mysql/http/HttpResult.dart';
import 'package:demo/data/mysql/httpstore/base/HttpStore.dart';
import 'package:demo/data/mysql/requestdatavo/RequestDataVOBase.dart';
import 'package:demo/data/mysql/responsedatavo/CreateTokenVO.dart';
import 'package:demo/data/mysql/responsedatavo/ResponseDataVOBase.dart';
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
  /// [T] 响应的 [requestDataVO] VO 模型。
  ///
  /// [method] GET POST
  ///
  /// [httpPath] 请求路径, 不包含 base path。
  ///
  /// [requestDataVO] 请求体。只有在 POST 请求时使用。使用函数形式以便请求内部对 vo 的准确性进行校验、捕获异常。
  ///
  /// [queryParameters] 请求 queryParameters。只有在 GET 请求时使用。
  ///
  /// [sameNotConcurrent] 不可并发标记。多个请求（可相同可不同），具有相同标记的请求不可并发。为 null 时代表不进行标记（即可并发）。
  ///
  /// [responseDataVO] 响应数据的 data VO 模型。
  ///
  /// [isBanAllOtherRequest] 若为 true，则其他请求全部禁止，只有当前请求继续直到当前请求结束。
  ///   - 若为 true，但同时存在其他请求，则当前请求也会失败。
  ///   - 若为 true，则 [sameNotConcurrent] 可为空。
  ///
  /// 向云端修改数据成功，而响应回本地修改 sqlite 数据失败 ———— 该问题会在 [SqliteCurd] 中进行处理。
  ///
  static Future<HttpResult> sendRequest({
    required HttpStore httpStore,
    required String method,
    required P httpPath,
    required RequestDataVOBase getRequestDataVO(),
    required Map<String, dynamic>? queryParameters,
    required Map<String, dynamic>? headers,
    required String? sameNotConcurrent,
    required T responseDataVO,
    bool isBanAllOtherRequest = false,
  }) async {
    try {
      final Map<String, dynamic> requestDataVO = getRequestDataVO().toJson();

      if (_isBanAllRequest) {
        return HttpResult<P, T>.failure(description: '已禁止全部请求！', responseDataVO: responseDataVO, httpPath: httpPath);
      }

      if (isBanAllOtherRequest) {
        // 若存在任意请求，则当前请求触发失败。
        if (_sameNotConcurrentMap.isNotEmpty) {
          return HttpResult<P, T>.failure(description: '要禁止其他全部请求时，已存在其他请求，需在没有任何请求的情况下才能触发！', responseDataVO: responseDataVO, httpPath: httpPath);
        }
        _isBanAllRequest = true;
      }

      if (sameNotConcurrent != null) {
        /// 若相同请求被并发
        if (_sameNotConcurrentMap.containsKey(sameNotConcurrent)) {
          return HttpResult<P, T>.failure(description: '相同标记的请求被并发！', responseDataVO: responseDataVO, httpPath: httpPath);
        }

        /// 当相同请求未并发时，对当前请求做阻断标记
        _sameNotConcurrentMap[sameNotConcurrent] = true;
      }

      SbLogger(
        code: null,
        viewMessage: null,
        data: null,
        description: '$method ' + dio.options.baseUrl + httpPath.PATH,
        exception: null,
        stackTrace: null,
      );

      if (isDev) {
        await Future<void>.delayed(const Duration(seconds: 2));
      }

      final String must = httpPath.PATH.split('/')[1];
      final bool isAuth;
      if (must == 'jwt') {
        isAuth = true;
      } else if (must == 'no_jwt') {
        isAuth = false;
      } else {
        throw 'Path is irregular! "$httpPath"';
      }

      /// 给请求头设置 token
      Map<String, dynamic>? authHeaders;
      if (isAuth) {
        final List<MToken> tokens = await ModelManager.queryRowsAsModels(connectTransaction: null, tableName: MToken().tableName);
        authHeaders = <String, dynamic>{'Authorization': 'Bearer ' + (tokens.isEmpty ? '' : (tokens.first.get_token ?? ''))};
      }

      final Response<Map<String, dynamic>> response = await dio.request<Map<String, dynamic>>(
        httpPath.PATH,
        data: requestDataVO,
        queryParameters: queryParameters,
        options: Options(method: method, headers: headers ?? authHeaders),
      );

      _sameNotConcurrentMap.remove(sameNotConcurrent);
      _isBanAllRequest = false;
      return HttpResult<P, T>.from(response, httpPath, responseDataVO);
    } catch (e, st) {
      _sameNotConcurrentMap.remove(sameNotConcurrent);
      _isBanAllRequest = false;
      return HttpResult<P, T>.failure(
        description: '请求出现异常！',
        responseDataVO: responseDataVO,
        httpPath: httpPath,
        exception: e,
        stackTrace: st,
      );
    }
  }

  ///
  ///
  ///
  ///
  ///
  static Future<bool> sendRequestForCreateToken<P extends HttpStoreBase_OF_CREATE_TOKEN>({
    required P httpPath,
    required RequestDataVOBase getRequestDataVO(),
  }) async {
    bool isSuccess = false;

    final HttpResult<P, CreateTokenVO> httpResult = await sendRequest(
      method: 'POST',
      httpPath: httpPath,
      getRequestDataVO: getRequestDataVO,
      queryParameters: null,
      sameNotConcurrent: null,
      responseDataVO: CreateTokenVO(),
      isBanAllOtherRequest: true,
      headers: null,
    );

    await httpResult.handle(
      doCancel: (HttpResult<P, CreateTokenVO> ht) async {
        isSuccess = false;
        SbLogger(
          code: ht.getCode,
          viewMessage: ht.getViewMessage,
          data: null,
          description: '生成 token 失败！${ht.getDescription}',
          exception: ht.getException,
          stackTrace: ht.getStackTrace,
        );
      },
      doContinue: (HttpResult<P, CreateTokenVO> ht) async {
        // 邮箱验证成功响应。
        if (ht.getCode == ht.getHttpPath.C1_02_02 || ht.getCode == ht.getHttpPath.C1_02_05) {
          // 云端 token 生成成功，存储至本地。
          final MToken newToken = MToken.createModel(
            id: null,
            aiid: null,
            uuid: null,
            created_at: SbHelper().newTimestamp,
            updated_at: SbHelper().newTimestamp,
            // 无论 token 值是否有问题，都进行存储。
            token: ht.getResponseDataVO.emailToken,
          );

          await db.delete(MToken().tableName);
          await db.insert(newToken.tableName, newToken.getRowJson);

          SbLogger(
            code: null,
            viewMessage: ht.getViewMessage,
            data: null,
            description: null,
            exception: null,
            stackTrace: null,
          );

          isSuccess = true;
          return true;
        }
        return false;
      },
    );
    return isSuccess;
  }

  ///
  ///
  ///
  ///
  ///
// static Future<bool> sendRequestForRefreshToken() async {
//   bool isSuccess = false;
//
//   try {
//     final List<MToken> tokens = await ModelManager.queryRowsAsModels(connectTransaction: null, tableName: MToken().tableName);
//
//     final Map<String, String> headers = <String, String>{'Authorization': 'Bearer ' + (tokens.isEmpty ? '' : (tokens.first.get_token ?? ''))};
//
//     final HttpResult<CreateTokenVO> httpResult = await sendRequest(
//       method: 'GET',
//       httpPath: HttpPath_LONGIN_AND_REGISTER_BY_EMAIL_SEND_EMAIL(),
//       headers: headers,
//       data: null,
//       queryParameters: null,
//       sameNotConcurrent: null,
//       dataVO: CreateTokenVO(),
//       isBanAllOtherRequest: true,
//     );
//
//     await httpResult.handle(
//       doCancel: (HttpResult<CreateTokenVO> ht) async {
//         isSuccess = false;
//         SbLogger(
//           code: ht.getCode,
//           viewMessage: ht.getViewMessage ?? '发生异常，请重新登陆！',
//           data: null,
//           description: ht.getDescription,
//           exception: ht.getException,
//           stackTrace: ht.getStackTrace,
//         );
//       },
//       doContinue: (HttpResult<CreateTokenVO> ht) async {
//         if (httpResult.getCode == 1) {
//           // 云端 token 生成成功，存储至本地。
//           final MToken newToken = MToken.createModel(
//             id: null,
//             aiid: null,
//             uuid: null,
//             created_at: SbHelper().newTimestamp,
//             updated_at: SbHelper().newTimestamp,
//             // 无论 token 值是否有问题，都进行存储。
//             token: httpResult.getDataVO.emailToken,
//           );
//
//           await db.delete(MToken().tableName);
//           await db.insert(newToken.tableName, newToken.getRowJson);
//
//           SbLogger(
//             code: null,
//             viewMessage: ht.getViewMessage ?? '登陆成功！',
//             data: null,
//             description: ht.getDescription,
//             exception: ht.getException,
//             stackTrace: ht.getStackTrace,
//           );
//
//           isSuccess = true;
//           return true;
//         }
//         return false;
//       },
//     );
//   } catch (e, st) {
//     isSuccess = false;
//     SbLogger(
//       code: null,
//       viewMessage: '发生异常，请重新尝试！',
//       data: null,
//       description: '刷新令牌异常！',
//       exception: e,
//       stackTrace: st,
//     );
//   }
//   return isSuccess;
// }
}
