import 'dart:async';

import 'package:dio/dio.dart';

class RefreshTokenInterceptor extends Interceptor {
  final bool _isRefreshing = false;
  final List<_QueuedRequest> _queue = [];

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle only 401
    if (err.response?.statusCode != 401) {
      return super.onError(err, handler);
    }

    // final storage = LoginLocalService();
    // final String? refreshToken = storage.refreshToken;

    // // No refresh token -> logout immediately
    // if (refreshToken == null) {
    //   _forceLogout();
    //   return super.onError(err, handler);
    // }

    // final completer = Completer<Response>();
    // _queue.add(_QueuedRequest(err.requestOptions, completer));

    // // Start refresh process only once
    // if (!_isRefreshing) {
    //   _isRefreshing = true;
    //   try {
    //     final data = await _refreshToken(refreshToken);

    //     if (data == null) {
    //       // Refresh failed -> logout and complete all with error
    //       _forceLogout();
    //       for (final req in _queue) {
    //         req.completer.completeError(err);
    //       }
    //     } else {
    //       await LoginLocalService().saveTokens(
    //         accessToken: data.accessToken!,
    //         refreshToken: data.refreshToken!,
    //       );

    //       // Save Tokens (uncomment if you want persistence)
    //       // storage.saveAccessToken(data.accessToken!);
    //       // storage.saveRefreshToken(data.refreshToken!);

    //       // Update global dio auth header
    //       DioSingleton.instance.updateAuth(data.accessToken!);

    //       // Retry queued requests
    //       await _retryQueuedRequests(data.accessToken!);
    //     }
    //   } catch (_) {
    //     _forceLogout();
    //   } finally {
    //     _isRefreshing = false;
    //     _queue.clear();
    //   }
    // }

    // handler.resolve(await completer.future);
  }

  /* --------------------------------------------------------------- */
  /* 🔁 REFRESH TOKEN API CALL                                       */
  /* --------------------------------------------------------------- */

  // Future<Data?> _refreshToken(String refreshToken) async {
  //   try {
  //     log("🔄 Refreshing token...");

  //     final dio = Dio(
  //       BaseOptions(
  //         baseUrl: url,
  //         connectTimeout: const Duration(seconds: 10),
  //         receiveTimeout: const Duration(seconds: 10),
  //       ),
  //     );

  //     final response = await dio.post(
  //       "/auth/v1/refresh",
  //       data: {"refresh_token": refreshToken},
  //       options: Options(
  //         validateStatus: (_) => true,
  //         headers: {
  //           "Accept": "application/json",
  //           // "Authorization": null, // important
  //         },
  //       ),
  //     );

  //     if (response.statusCode == 200) {
  //       return LoginResponseModel.fromJson(response.data).data;
  //     }

  //     return null;
  //   } catch (e) {
  //     log("❌ Refresh token error: $e");
  //     return null;
  //   }
  // }

  /* --------------------------------------------------------------- */
  /* 🔁 RETRY QUEUED REQUESTS                                        */
  /* --------------------------------------------------------------- */

  // Future<void> _retryQueuedRequests(String accessToken) async {
  //   final dio = DioSingleton.instance.dio;

  //   for (final job in _queue) {
  //     try {
  //       job.options.headers[NetworkConstants.AUTHORIZATION] =
  //           "Bearer $accessToken";

  //       final response = await dio.fetch(job.options);
  //       job.completer.complete(response);
  //     } catch (e) {
  //       job.completer.completeError(e);
  //     }
  //   }
  // }

  /* --------------------------------------------------------------- */
  /* 🧹 LOGOUT HANDLER                                               */
  /* --------------------------------------------------------------- */

  //   void _forceLogout() {
  //     log("🚪 Logging out due to invalid refresh token");

  //     final storage = LoginLocalService();
  //     storage.deleteTokens();

  //     nav.toLogin();
  //   }
}

/* --------------------------------------------------------------- */
/* 📦 DATA CLASS FOR QUEUED REQUESTS                               */
/* --------------------------------------------------------------- */

class _QueuedRequest {
  final RequestOptions options;
  final Completer<Response> completer;
  _QueuedRequest(this.options, this.completer);
}
