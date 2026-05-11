import 'dart:convert';
import 'package:flutter/foundation.dart';

class AppLogger {
  static void info(Object? data, {String from = 'Unknown'}) {
    if (kDebugMode) {
      _log('💡', data, from);
    }
  }

  static void warning(Object? data, {String from = 'Unknown'}) {
    if (kDebugMode) {
      _log('⚠️', data, from);
    }
  }

  static void error(
    Object? data, {
    String from = 'Unknown',
    StackTrace? stackTrace,
  }) {
    if (kDebugMode) {
      _log('⛔', data, from, stackTrace: stackTrace);
    }
  }

  static void _log(
    String emoji,
    Object? data,
    String from, {
    StackTrace? stackTrace,
  }) {
    final formattedData = _formatData(data);

    final logMessage = '''
------------------------------------------
 $emoji $formattedData
 📍 From: $from
------------------------------------------
''';

    debugPrint(logMessage);

    if (stackTrace != null) {
      debugPrint('🧵 StackTrace:\n$stackTrace');
    }
  }

  /// Handles all data types safely
  static String _formatData(Object? data) {
    if (data == null) return 'null';

    if (data is String) return data;

    if (data is Map || data is List) {
      return const JsonEncoder.withIndent('  ').convert(data);
    }

    if (data is Exception || data is Error) {
      return data.toString();
    }

    return data.toString();
  }
}

// AppLogger.info('User joined room', from: 'VideoRoom');

// AppLogger.info(12345, from: 'Coins');

// AppLogger.warning({'userId': 12, 'status': 'muted'}, from: 'Audio');

// AppLogger.error(
//   Exception('Agora connection failed'),
//   from: 'AgoraService',
//   stackTrace: StackTrace.current,
// );
