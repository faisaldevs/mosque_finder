// import 'package:bcs_booster_app/shared/networks/dio/log.dart';
// import 'package:bcs_booster_app/shared/networks/endpoints.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';

// final class DioSingleton {
//   static final DioSingleton _singleton = DioSingleton._internal();
//   static CancelToken cancelToken = CancelToken();
//   DioSingleton._internal();

//   static DioSingleton get instance => _singleton;

//   late Dio dio;

//   void create() {
//     BaseOptions options = BaseOptions(
//         baseUrl: url,
//         connectTimeout: const Duration(milliseconds: 100000),
//         receiveTimeout: const Duration(milliseconds: 100000),
//         headers: {
//           NetworkConstants.ACCEPT: NetworkConstants.ACCEPT_TYPE,
//           NetworkConstants.ACCEPT_LANGUAGE: "kKeyLanguage",
//           NetworkConstants.APP_KEY: NetworkConstants.APP_KEY_VALUE,
//         });
//     dio = Dio(options)..interceptors.add(DioLogger());
//   }

//   void update(String auth) {
//     if (kDebugMode) {
//       print("Dio update");
//     }
//     BaseOptions options = BaseOptions(
//       baseUrl: url,
//       responseType: ResponseType.json,
//       headers: {
//         NetworkConstants.ACCEPT: NetworkConstants.ACCEPT_TYPE,
//         NetworkConstants.ACCEPT_LANGUAGE: "kKeyLanguage",
//         NetworkConstants.APP_KEY: NetworkConstants.APP_KEY_VALUE,
//         NetworkConstants.AUTHORIZATION: "Bearer $auth",
//       },
//       connectTimeout: const Duration(milliseconds: 100000),
//       receiveTimeout: const Duration(milliseconds: 100000),
//     );
//     dio = Dio(options)..interceptors.add(DioLogger());
//   }

//   void updateLanguage(String countryCode) {
//     if (kDebugMode) {
//       print("Dio update $countryCode");
//     }
//     BaseOptions options = BaseOptions(
//       baseUrl: url,
//       responseType: ResponseType.json,
//       headers: {
//         NetworkConstants.ACCEPT: NetworkConstants.ACCEPT_TYPE,
//         NetworkConstants.ACCEPT_LANGUAGE: countryCode,
//         NetworkConstants.APP_KEY: NetworkConstants.APP_KEY_VALUE,
//         NetworkConstants.AUTHORIZATION: "Bearer Token ",
//       },
//       connectTimeout: const Duration(milliseconds: 100000),
//       receiveTimeout: const Duration(milliseconds: 100000),
//     );
//     dio = Dio(options)..interceptors.add(DioLogger());
//   }
// }

// Future<Response> postHttp(String path, [dynamic data]) =>
//     DioSingleton.instance.dio
//         .post(path, data: data, cancelToken: DioSingleton.cancelToken);

// Future<Response> putHttp(String path, [dynamic data]) =>
//     DioSingleton.instance.dio
//         .put(path, data: data, cancelToken: DioSingleton.cancelToken);

// Future<Response> getHttp(String path, [dynamic data]) =>
//     DioSingleton.instance.dio.get(path, cancelToken: DioSingleton.cancelToken);

// Future<Response> deleteHttp(String path, [dynamic data]) =>
//     DioSingleton.instance.dio
//         .delete(path, data: data, cancelToken: DioSingleton.cancelToken);

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mosque_finder_app/core/networks/dio/interceptor/error.dart';
import 'package:mosque_finder_app/core/networks/dio/interceptor/log.dart';
import 'package:mosque_finder_app/core/networks/endpoints.dart';

final class DioSingleton {
  static final DioSingleton _singleton = DioSingleton._internal();
  static DioSingleton get instance => _singleton;

  late final Dio dio;

  DioSingleton._internal() {
    final options = BaseOptions(
      baseUrl: url,
      connectTimeout: const Duration(milliseconds: 100000),
      receiveTimeout: const Duration(milliseconds: 100000),
      headers: {
        NetworkConstants.ACCEPT: NetworkConstants.ACCEPT_TYPE,
        NetworkConstants.ACCEPT_LANGUAGE: "en",
        NetworkConstants.APP_KEY: NetworkConstants.APP_KEY_VALUE,
      },
      responseType: ResponseType.json,
    );

    dio = Dio(options)
      ..interceptors.addAll([DioLogger(), RefreshTokenInterceptor()]);
  }

  /// Update Authorization header only
  void updateAuth(String auth) {
    if (kDebugMode) print("Dio updateAuth");
    dio.options.headers[NetworkConstants.AUTHORIZATION] = "Bearer $auth";
  }

  /// Update language header only
  void updateLanguage(String countryCode) {
    if (kDebugMode) print("Dio updateLanguage: $countryCode");
    dio.options.headers[NetworkConstants.ACCEPT_LANGUAGE] = countryCode;
  }
}

/* ------------------------------------------------------------------ */
/* GENERIC HELPERS                                                    */
/* ------------------------------------------------------------------ */

Future<Response<T>> getHttp<T>(
  String path, {
  Map<String, dynamic>? query,
  CancelToken? cancelToken,
}) => DioSingleton.instance.dio.get<T>(
  path,
  queryParameters: query,
  cancelToken: cancelToken ?? CancelToken(),
);

Future<Response<T>> postHttp<T>(
  String path, {
  dynamic data,
  CancelToken? cancelToken,
}) => DioSingleton.instance.dio.post<T>(
  path,
  data: data,
  cancelToken: cancelToken ?? CancelToken(),
);

Future<Response<T>> putHttp<T>(
  String path, {
  dynamic data,
  CancelToken? cancelToken,
}) => DioSingleton.instance.dio.put<T>(
  path,
  data: data,
  cancelToken: cancelToken ?? CancelToken(),
);

Future<Response<T>> deleteHttp<T>(
  String path, {
  dynamic data,
  CancelToken? cancelToken,
}) => DioSingleton.instance.dio.delete<T>(
  path,
  data: data,
  cancelToken: cancelToken ?? CancelToken(),
);
