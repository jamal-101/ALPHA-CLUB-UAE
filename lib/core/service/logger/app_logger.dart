import 'package:flutter/foundation.dart';
import 'dart:developer' as developer;
import 'package:intl/intl.dart';

enum LogLevel { debug, info, warning, error, critical }

class AppLogger {
  static final AppLogger _instance = AppLogger._internal();
  static const String _logTag = '🔷 ALPHA_CLUB';

  factory AppLogger() {
    return _instance;
  }

  AppLogger._internal();

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
    buffer.writeln('📤 API REQUEST');
    buffer.writeln('├─ Endpoint: $endpoint');
    buffer.writeln('├─ Method: $method');

    if (headers != null && headers.isNotEmpty) {
      buffer.writeln('├─ Headers:');
      headers.forEach((key, value) {
        // Mask sensitive data
        final displayValue = _maskSensitiveData(key, value);
        buffer.writeln('│  ├─ $key: $displayValue');
      });
    }

    if (body != null) {
      buffer.writeln('├─ Body:');
      final bodyString = _formatJson(body);
      buffer.writeln('│  $bodyString');
    }

    buffer.writeln('└─ End Request');

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
    buffer.writeln('📥 API RESPONSE');
    buffer.writeln('├─ Endpoint: $endpoint');
    buffer.writeln('├─ Status Code: $statusCode');
    buffer.writeln('├─ Duration: ${duration}ms');

    if (responseData != null) {
      buffer.writeln('├─ Response Data:');
      final dataString = _formatJson(responseData);
      buffer.writeln('│  $dataString');
    }

    buffer.writeln('└─ End Response');

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
    buffer.writeln('❌ API ERROR');
    buffer.writeln('├─ Endpoint: $endpoint');
    buffer.writeln('├─ Method: $method');

    if (statusCode != null) {
      buffer.writeln('├─ Status Code: $statusCode');
    }

    buffer.writeln('├─ Error: $error');

    if (responseData != null) {
      buffer.writeln('├─ Error Response:');
      final dataString = _formatJson(responseData);
      buffer.writeln('│  $dataString');
    }

    buffer.writeln('└─ End Error');

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
        return data;
      }
      if (data is Map || data is List) {
        return data.toString();
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
