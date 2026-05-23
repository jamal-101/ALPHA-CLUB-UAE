import 'package:flutter/foundation.dart';
import 'dart:developer' as developer;
import 'package:intl/intl.dart';
import 'dart:convert';

enum LogLevel { debug, info, warning, error, critical }

class AppLogger {
  static final AppLogger _instance = AppLogger._internal();
  static const String _logTag = '🔷 ALPHA_CLUB';

  // ANSI Color Codes
  static const String _reset = '\x1B[0m';
  static const String _white = '\x1B[97m';
  static const String _brightWhite = '\x1B[97;1m';
  static const String _cyan = '\x1B[96m';
  static const String _green = '\x1B[92m';
  static const String _red = '\x1B[91m';
  static const String _magenta = '\x1B[95m';

  factory AppLogger() {
    return _instance;
  }

  AppLogger._internal();

  /// Apply color to text
  static String _colorize(String text, String color) {
    return '$color$text$_reset';
  }

  /// Format timestamp
  static String _getTimestamp() {
    return DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(DateTime.now());
  }

  /// Get log level emoji and color
  static String _getLevelEmoji(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return '🐛';
      case LogLevel.info:
        return 'ℹ️';
      case LogLevel.warning:
        return '⚠️';
      case LogLevel.error:
        return '❌';
      case LogLevel.critical:
        return '🔴';
    }
  }

  /// Format log message
  static String _formatLog(
    String message,
    LogLevel level,
    String? tag,
    dynamic error,
    StackTrace? stackTrace,
  ) {
    final timestamp = _getTimestamp();
    final emoji = _getLevelEmoji(level);
    final levelName = level.toString().split('.').last.toUpperCase();
    final finalTag = tag ?? _logTag;

    StringBuffer buffer = StringBuffer();
    buffer.writeln('$emoji [$timestamp] [$levelName] $finalTag');
    buffer.writeln('├─ Message: $message');

    if (error != null) {
      buffer.writeln('├─ Error: $error');
    }

    if (stackTrace != null) {
      buffer.writeln('├─ Stack Trace:');
      final lines = stackTrace.toString().split('\n');
      for (int i = 0; i < lines.length && i < 5; i++) {
        buffer.writeln('│  ${lines[i]}');
      }
    }

    buffer.writeln('└─ End Log');
    return buffer.toString();
  }

  /// Debug log
  static void debug(
    String message, {
    String? tag,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    final log = _formatLog(message, LogLevel.debug, tag, error, stackTrace);
    if (kDebugMode) {
      debugPrint(log);
      developer.log(message, name: tag ?? _logTag);
    }
  }

  /// Info log
  static void info(
    String message, {
    String? tag,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    final log = _formatLog(message, LogLevel.info, tag, error, stackTrace);
    if (kDebugMode) {
      debugPrint(log);
      developer.log(message, name: tag ?? _logTag, level: 800);
    }
  }

  /// Warning log
  static void warning(
    String message, {
    String? tag,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    final log = _formatLog(message, LogLevel.warning, tag, error, stackTrace);
    if (kDebugMode) {
      debugPrint(log);
      developer.log(message, name: tag ?? _logTag, level: 900);
    }
  }

  /// Error log
  static void error(
    String message, {
    String? tag,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    final log = _formatLog(message, LogLevel.error, tag, error, stackTrace);
    if (kDebugMode) {
      debugPrint(log);
      developer.log(message, name: tag ?? _logTag, level: 1000);
    }
  }

  /// Critical log (app crash)
  static void critical(
    String message, {
    String? tag,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    final log = _formatLog(message, LogLevel.critical, tag, error, stackTrace);
    if (kDebugMode) {
      debugPrint(log);
      developer.log(message, name: tag ?? _logTag, level: 1200);
    }
  }

  /// Log API Request
  static void logRequest({
    required String endpoint,
    required String method,
    Map<String, dynamic>? headers,
    dynamic body,
    String? tag,
  }) {
    StringBuffer buffer = StringBuffer();
    buffer.writeln(_colorize('📤 API REQUEST', _cyan));
    buffer.writeln(_colorize('├─ Endpoint: $endpoint', _white));
    buffer.writeln(_colorize('├─ Method: $method', _white));

    if (headers != null && headers.isNotEmpty) {
      buffer.writeln(_colorize('├─ Headers:', _white));
      headers.forEach((key, value) {
        // Mask sensitive data
        final displayValue = _maskSensitiveData(key, value);
        buffer.writeln(_colorize('│  ├─ $key: $displayValue', _white));
      });
    }

    if (body != null) {
      buffer.writeln(_colorize('├─ Body:', _white));
      final bodyString = _formatJson(body);
      // Split by lines and colorize each
      bodyString.split('\n').forEach((line) {
        buffer.writeln(_colorize('│  $line', _brightWhite));
      });
    }

    buffer.writeln(_colorize('└─ End Request', _cyan));

    if (kDebugMode) {
      debugPrint(buffer.toString());
    }
  }

  /// Log API Response
  static void logResponse({
    required String endpoint,
    required int statusCode,
    required dynamic responseData,
    required int duration,
    String? tag,
  }) {
    StringBuffer buffer = StringBuffer();
    buffer.writeln(_colorize('📥 API RESPONSE', _green));
    buffer.writeln(_colorize('├─ Endpoint: $endpoint', _white));
    buffer.writeln(_colorize('├─ Status Code: $statusCode', _white));
    buffer.writeln(_colorize('├─ Duration: ${duration}ms', _white));

    if (responseData != null) {
      buffer.writeln(_colorize('├─ Response Data:', _white));
      final dataString = _formatJson(responseData);
      // Split by lines and colorize each
      dataString.split('\n').forEach((line) {
        buffer.writeln(_colorize('│  $line', _brightWhite));
      });
    }

    buffer.writeln(_colorize('└─ End Response', _green));

    if (kDebugMode) {
      debugPrint(buffer.toString());
    }
  }

  /// Log API Error
  static void logApiError({
    required String endpoint,
    required String method,
    required dynamic error,
    int? statusCode,
    dynamic responseData,
    String? tag,
  }) {
    StringBuffer buffer = StringBuffer();
    buffer.writeln(_colorize('❌ API ERROR', _red));
    buffer.writeln(_colorize('├─ Endpoint: $endpoint', _white));
    buffer.writeln(_colorize('├─ Method: $method', _white));

    if (statusCode != null) {
      buffer.writeln(_colorize('├─ Status Code: $statusCode', _white));
    }

    buffer.writeln(_colorize('├─ Error: $error', _red));

    if (responseData != null) {
      buffer.writeln(_colorize('├─ Error Response:', _white));
      final dataString = _formatJson(responseData);
      dataString.split('\n').forEach((line) {
        buffer.writeln(_colorize('│  $line', _brightWhite));
      });
    }

    buffer.writeln(_colorize('└─ End Error', _red));

    if (kDebugMode) {
      debugPrint(buffer.toString());
    }
  }

  /// Log App Crash
  static void logCrash({
    required String message,
    required dynamic error,
    required StackTrace stackTrace,
    String? tag,
  }) {
    StringBuffer buffer = StringBuffer();
    buffer.writeln('🔴 APP CRASH');
    buffer.writeln('├─ Message: $message');
    buffer.writeln('├─ Error: $error');
    buffer.writeln('├─ Stack Trace:');

    final lines = stackTrace.toString().split('\n');
    for (int i = 0; i < lines.length; i++) {
      final prefix = i == lines.length - 1 ? '└─' : '├─';
      buffer.writeln('│  $prefix ${lines[i]}');
    }

    buffer.writeln('└─ End Crash');

    if (kDebugMode) {
      debugPrint(buffer.toString());
    }
  }

  /// Format JSON for readable output
  static String _formatJson(dynamic data) {
    try {
      if (data is String) {
        // Try to parse string as JSON
        try {
          final decoded = jsonDecode(data);
          const encoder = JsonEncoder.withIndent('  ');
          return encoder.convert(decoded);
        } catch (_) {
          return data;
        }
      }
      if (data is Map || data is List) {
        // Pretty print JSON with indentation
        const encoder = JsonEncoder.withIndent('  ');
        return encoder.convert(data);
      }
      return data.toString();
    } catch (e) {
      return data.toString();
    }
  }

  /// Mask sensitive data (passwords, tokens, etc.)
  static String _maskSensitiveData(String key, dynamic value) {
    final lowerKey = key.toLowerCase();

    if (lowerKey.contains('password') ||
        lowerKey.contains('token') ||
        lowerKey.contains('authorization') ||
        lowerKey.contains('secret') ||
        lowerKey.contains('api_key')) {
      return '***MASKED***';
    }

    return value.toString();
  }

  /// Log performance metrics
  static void logPerformance({
    required String operation,
    required int duration,
    String? tag,
  }) {
    final message = '⏱️ Performance: $operation took ${duration}ms';
    info(message, tag: tag ?? 'PERFORMANCE');
  }

  /// Log user action
  static void logUserAction({
    required String action,
    Map<String, dynamic>? data,
    String? tag,
  }) {
    StringBuffer buffer = StringBuffer();
    buffer.writeln('👤 USER ACTION');
    buffer.writeln('├─ Action: $action');

    if (data != null && data.isNotEmpty) {
      buffer.writeln('├─ Data:');
      data.forEach((key, value) {
        buffer.writeln('│  ├─ $key: $value');
      });
    }

    buffer.writeln('└─ End Action');

    if (kDebugMode) {
      debugPrint(buffer.toString());
    }
  }

  /// Log navigation
  static void logNavigation({
    required String from,
    required String to,
    Map<String, dynamic>? arguments,
    String? tag,
  }) {
    StringBuffer buffer = StringBuffer();
    buffer.writeln('🧭 NAVIGATION');
    buffer.writeln('├─ From: $from');
    buffer.writeln('├─ To: $to');

    if (arguments != null && arguments.isNotEmpty) {
      buffer.writeln('├─ Arguments:');
      arguments.forEach((key, value) {
        buffer.writeln('│  ├─ $key: $value');
      });
    }

    buffer.writeln('└─ End Navigation');

    if (kDebugMode) {
      debugPrint(buffer.toString());
    }
  }
}
