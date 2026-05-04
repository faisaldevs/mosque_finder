import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mosque_finder_app/app/di/di.dart';
import 'package:mosque_finder_app/core/services/logger.dart';

class DioLogger extends Interceptor {
  DioLogger({
    this.level = LogLevel.debug,
    this.redactedHeaders = const {'authorization', 'cookie'},
    this.truncateBody = true,
    CustomLogger? logger,
  }) : _log = logger ?? locator<CustomLogger>();

  final CustomLogger _log;
  final LogLevel level;
  final Set<String> redactedHeaders;
  final bool truncateBody;

  static const _startKey = '_startAt';
  static const _bodyLimit = 400;

  /* ------------------------------------------------------------------ */
  /* REQUEST                                                            */
  /* ------------------------------------------------------------------ */
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logIf(LogLevel.debug, () {
      options.extra[_startKey] = DateTime.now().microsecondsSinceEpoch;

      final sb = StringBuffer()
        ..writeln('🛰️  REQUEST  → ${options.method} ${options.uri}')
        ..writeln('↗︎ query   ▸ ${options.queryParameters}')
        ..writeln(
          '↗︎ headers ▸ ${_redact(_normalizeHeaders(options.headers))}',
        );

      if (level.index >= LogLevel.verbose.index && options.data != null) {
        sb.writeln('↗︎ body    ▸ ${_pretty(options.data)}');
      }
      return sb.toString();
    });

    super.onRequest(options, handler);
  }

  /* ------------------------------------------------------------------ */
  /* RESPONSE                                                           */
  /* ------------------------------------------------------------------ */
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logIf(LogLevel.debug, () {
      final started = response.requestOptions.extra[_startKey] as int?;
      final elapsedMs = started == null
          ? ''
          : ' • ${(DateTime.now().microsecondsSinceEpoch - started) ~/ 1000} ms';

      final size = response.data?.toString().length ?? 0;

      final sb = StringBuffer()
        ..writeln(
          '✅ RESPONSE ← ${response.statusCode} ${response.statusMessage}$elapsedMs',
        )
        ..writeln(
          '⬇︎ ${response.requestOptions.method} ${response.requestOptions.uri}',
        )
        ..writeln(
          '⬇︎ headers ▸ ${_redact(_normalizeHeaders(response.headers.map))}',
        )
        ..writeln('⬇︎ size    ▸ ${size}B');

      if (level.index >= LogLevel.verbose.index && response.data != null) {
        sb.writeln('⬇︎ body    ▸ ${_pretty(response.data)}');
      }
      return sb.toString();
    });

    super.onResponse(response, handler);
  }

  /* ------------------------------------------------------------------ */
  /* ERROR                                                              */
  /* ------------------------------------------------------------------ */
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logIf(LogLevel.error, () {
      final sb = StringBuffer()
        ..writeln(
          '⛔ ERROR    ← ${err.response?.statusCode ?? ''} ${err.type}: ${err.message}',
        )
        ..writeln('⤵︎ ${err.requestOptions.method} ${err.requestOptions.uri}');

      if (err.response != null) {
        sb.writeln(
          '⤵︎ headers ▸ ${_redact(_normalizeHeaders(err.response!.headers.map))}',
        );
        if (level.index >= LogLevel.verbose.index &&
            err.response!.data != null) {
          sb.writeln('⤵︎ body    ▸ ${_pretty(err.response!.data)}');
        }
      }
      return sb.toString();
    });

    super.onError(err, handler);
  }

  /* ------------------------------------------------------------------ */
  /* HELPERS                                                            */
  /* ------------------------------------------------------------------ */

  void _logIf(LogLevel logLevel, String Function() builder) {
    if (_log.isEnabled && logLevel.index >= level.index) {
      _log.write(logLevel, builder());
    }
  }

  Map<String, dynamic> _normalizeHeaders(Map<String, dynamic> src) =>
      src.map((k, v) => MapEntry(k, v is List ? v.join(', ') : v.toString()));

  Map<String, dynamic> _redact(Map<String, dynamic> src) => {
    for (final k in src.keys)
      k: redactedHeaders.contains(k.toLowerCase()) ? '•••••' : src[k],
  };

  String _pretty(dynamic data) {
    try {
      String out;
      if (data is Map || data is List) {
        out = const JsonEncoder.withIndent('  ').convert(data);
      } else if (data is FormData) {
        final fields = {for (final f in data.fields) f.key: f.value};
        final files = data.files.map((f) => f.key).toList();
        out = 'FormData(fields: $fields, files: $files)';
      } else {
        out = data.toString();
      }
      return _truncate(out);
    } catch (_) {
      return _truncate(data.toString());
    }
  }

  String _truncate(String input) {
    if (!truncateBody) return input;
    return (input.length <= _bodyLimit)
        ? input
        : '${input.substring(0, _bodyLimit)}… [truncated]';
  }
}
