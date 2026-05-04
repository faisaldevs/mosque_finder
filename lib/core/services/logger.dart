import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// ─────────────────────────────────────────────────────────────────────────
///  CUSTOM LOGGER  (same public API you wrote, plus a helper extension)
/// ─────────────────────────────────────────────────────────────────────────

enum LogLevel { verbose, debug, info, warning, error, wtf, none }

class CustomLogger {
  static CustomLogger? _instance;

  factory CustomLogger() {
    _instance ??= CustomLogger._internal(
      // 👇 Compile-time switch: in release builds nothing is logged.
      logThreshold: kReleaseMode ? LogLevel.none : LogLevel.verbose,
    );
    return _instance!;
  }

  late final Logger _logger;
  final _buf = StringBuffer();
  late LogLevel _threshold;

  CustomLogger._internal({
    LogLevel logThreshold = LogLevel.verbose,
    bool colors = true,
    bool printTime = true,
    bool printEmojis = true,
    int methodCount = 2,
    int errorMethodCount = 5,
    int lineLength = 120,
  }) {
    _threshold = logThreshold;
    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: methodCount,
        errorMethodCount: errorMethodCount,
        lineLength: lineLength,
        colors: colors,
        printTime: printTime,
        printEmojis: printEmojis,
      ),
    );
  }

  /*–––––––– existing helpers ––––––––*/

  bool _should(LogLevel lvl) => lvl.index >= _threshold.index;

  void verbose(String msg, [Object? err, StackTrace? st]) {
    if (_should(LogLevel.verbose)) _out('VERBOSE', msg, err, st, _logger.v);
  }

  void debug(String msg, [Object? err, StackTrace? st]) {
    if (_should(LogLevel.debug)) _out('DEBUG', msg, err, st, _logger.d);
  }

  void info(String msg, [Object? err, StackTrace? st]) {
    if (_should(LogLevel.info)) _out('INFO', msg, err, st, _logger.i);
  }

  void warning(String msg, [Object? err, StackTrace? st]) {
    if (_should(LogLevel.warning)) _out('WARNING', msg, err, st, _logger.w);
  }

  void error(String msg, [Object? err, StackTrace? st]) {
    if (_should(LogLevel.error)) _out('ERROR', msg, err, st, _logger.e);
  }

  void wtf(String msg, [Object? err, StackTrace? st]) {
    if (_should(LogLevel.wtf)) _out('WTF', msg, err, st, _logger.wtf);
  }

  String getLogs() => _buf.toString();
  void clearLogs() => _buf.clear();

  /*–––––––– private ––––––––*/
  void _out(
    String tag,
    String msg,
    Object? err,
    StackTrace? st,
    Function(String, {Object? error, StackTrace? stackTrace}) fn,
  ) {
    _buf.writeln('${DateTime.now().toIso8601String()} [$tag] $msg');
    if (err != null) _buf.writeln('↳ Error: $err');
    if (st != null) _buf.writeln('↳ StackTrace: $st');
    fn(msg, error: err, stackTrace: st);
  }
}

/*───────────────────────── NEW helper extension ─────────────────────────*/

extension LogWriter on CustomLogger {
  static const _chunk = 800; // avoid 4 KB logcat cutoff

  /// Safe long-message writer used by the Dio interceptor.
  void write(LogLevel lvl, String msg) {
    for (var i = 0; i < msg.length; i += _chunk) {
      final slice = msg.substring(
        i,
        i + _chunk > msg.length ? msg.length : i + _chunk,
      );
      switch (lvl) {
        case LogLevel.verbose:
          verbose(slice);
          break;
        case LogLevel.debug:
          debug(slice);
          break;
        case LogLevel.info:
          info(slice);
          break;
        case LogLevel.warning:
          warning(slice);
          break;
        case LogLevel.error:
          error(slice);
          break;
        case LogLevel.wtf:
          wtf(slice);
          break;
        default:
          break; // LogLevel.none
      }
    }
  }

  bool get isEnabled => _threshold != LogLevel.none;
}
