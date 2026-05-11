import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../helpers/applog.dart';
import '../../helpers/custome_loader.dart';
import '../../helpers/toaster.dart';
import '../../prefs/prefs.dart';

class DioHelper {
  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );

  DioHelper._internal();

  static Future<void> init() async {
    _dio.interceptors.add(_PrettyLoggerInterceptor());
  }

  static Future<Map<String, String>> _getDefaultHeaders() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final deviceInfo = DeviceInfoPlugin();

    String deviceId = '';
    String deviceType = '';
    String brandModel = '';
    if (defaultTargetPlatform == TargetPlatform.android) {
      final android = await deviceInfo.androidInfo;
      deviceId = android.id ?? '';
      deviceType = 'ANDROID';
      brandModel = '${android.brand}, ${android.model}';
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      final ios = await deviceInfo.iosInfo;
      deviceType = 'IOS';
      deviceId = ios.identifierForVendor ?? '';
      brandModel = ios.utsname.machine ?? '';
    }

    return {
      'Authorization': 'Bearer ${Prefs.getToken()}',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'versionName': packageInfo.version,
      'versionCode': packageInfo.buildNumber,
      'deviceType': deviceType,
      'deviceId': deviceId,
      'brandModel': brandModel,
      'packageName': packageInfo.packageName,
      'locale': 'en',
    };
  }

  // static Future<bool> _hasInternet() async {
  //   final result = await Connectivity().checkConnectivity();
  //   return !result.contains(ConnectivityResult.none);
  // }

  static Future<bool> _hasInternet() async {
    final result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }

  static _RequestBuilder builder() => _RequestBuilder();
}

class _RequestBuilder {
  static const String tag = 'DioHelper';

  String _method = 'GET';
  String _url = '';
  Map<String, dynamic>? _data;

  _RequestBuilder setMethod(String method) {
    _method = method.toUpperCase();
    return this;
  }

  _RequestBuilder setUrl(String url) {
    _url = url;
    return this;
  }

  _RequestBuilder setData(Map<String, dynamic>? data) {
    _data = data;
    return this;
  }

  Future<void> execute<T>({
    required Function(T response) onSuccess,
    required Function(String message, {String? code}) onFailure,
    T Function(Map<String, dynamic>)? fromJson,
    List<T> Function(List)? fromJsonList,
  }) async {
    try {
      if (!await DioHelper._hasInternet()) {
        AppToast.short('No Internet Connection');
        onFailure('No Internet Connection');
        return;
      }

      final headers = await DioHelper._getDefaultHeaders();

      final response = await DioHelper._dio.request(
        _url,
        data: _data != null ? jsonEncode(_data) : null,
        options: Options(method: _method, headers: headers),
      );

      final statusCode = response.statusCode ?? -1;
      dynamic rawData = response.data;

      // ==========================================================
      // ✅ HTTP SUCCESS (200–299)
      // ==========================================================
      if (statusCode >= 200 && statusCode < 300) {
        if (rawData == null || rawData.toString().isEmpty) {
          onFailure('Empty response from server');
          return;
        }

        // 🔥 If backend returns JSON as String → decode
        if (rawData is String) {
          try {
            rawData = jsonDecode(rawData);
          } catch (_) {}
        }

        try {
          // ======================================================
          // ✅ GLOBAL BACKEND STATUS CHECK
          // status != 1 → FAILURE
          // ======================================================
          if (rawData is Map && rawData.containsKey('status')) {
            final int backendStatus =
                int.tryParse(rawData['status']?.toString() ?? '') ?? 0;

            final String backendCode = rawData['code']?.toString() ?? '';

            final String backendMessage =
                rawData['msg']?.toString() ?? 'Something went wrong.';

            if (backendStatus != 1) {
              _handleBackendError(
                backendCode,
                backendMessage,
                onFailure,
              );
              return;
            }
          }

          // ======================================================
          // ✅ NORMAL PARSING FLOW
          // ======================================================

          dynamic parsedResult;

          // 🧩 Map → Single model
          if (rawData is Map && fromJson != null) {
            parsedResult = await _safeCompute<Map<String, dynamic>, T>(
              (json) => fromJson(json),
              Map<String, dynamic>.from(rawData),
            );
          }
          // 🧩 List → List model
          else if (rawData is List && fromJsonList != null) {
            parsedResult = await _safeCompute<List, List<T>>(
              (list) => fromJsonList(list),
              List.from(rawData),
            );
          }
          // 🧩 Primitive / fallback
          else {
            parsedResult = rawData;
          }

          onSuccess(parsedResult as T);
        } catch (e, st) {
          AppLogger.error('⚠️ Parsing failed: $e\n$st', from: tag);
          onFailure('Failed to parse response');
        }
      }
      // ==========================================================
      // ❌ HTTP ERROR
      // ==========================================================
      else {
        _handleError(statusCode, onFailure, rawData);
      }
    }
    // ==========================================================
    // ❌ DIO EXCEPTION
    // ==========================================================
    on DioException catch (e, st) {
      AppLogger.error('❌ DioException: ${e.message}\n$st', from: tag);
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.unknown) {
        onFailure('No Internet Connection');
        return;
      }

      // ==========================================================
      // ❌ TIMEOUT CASES
      // ==========================================================
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        onFailure('Request timeout. Please try again.');
        return;
      }
      if (e.response != null) {
        _handleError(
          e.response?.statusCode ?? -1,
          onFailure,
          e.response?.data,
        );
      } else {
        onFailure('Network Error: ${e.message}');
      }
    }
    // ==========================================================
    // ❌ UNKNOWN ERROR
    // ==========================================================
    catch (e, st) {
      debugPrint('💥 Unexpected Error: $e\n$st');
      onFailure('Something went wrong: ${e.toString()}');
    } finally {
      Loader.hide();
    }
  }

  // ==========================================================
  // ✅ SAFE COMPUTE
  // ==========================================================
  Future<R> _safeCompute<Q, R>(R Function(Q) computeFn, Q message) async {
    try {
      return await compute(computeFn, message);
    } catch (e, st) {
      debugPrint('⚠️ Isolate compute failed: $e\n$st');
      return computeFn(message);
    }
  }

  // ==========================================================
  // ✅ BACKEND ERROR HANDLER
  // ==========================================================
  void _handleBackendError(
    String code,
    String message,
    Function(String, {String? code}) onFailure,
  ) {
    switch (code) {
      case 'INVALID_CREDENTIALS':
        message = 'Invalid phone number or password.';
        break;
      case 'USER_BANNED':
        message = 'Your account has been banned.';
        break;
      case 'LIVE_BANNED':
        message = 'You are banned from going live.';
        break;
      case 'ROOM_USER_BANNED':
        message = 'You are banned from this room.';
        break;
      case 'NOT_ELIGIBLE_FOR_LIVE':
        message = 'You are not eligible to start a live session.';
        break;
      case 'LIVE_ENDED':
        message = 'This live session has already ended.';
        break;
      case 'SEAT_OCCUPIED':
        message = 'This seat is already occupied.';
        break;
      case 'ALREADY_FOLLOWING':
        message = 'You are already following this user.';
        break;
      case 'VALIDATION_ERROR':
        message = message.isNotEmpty ? message : 'Invalid input data.';
        break;
      case 'BAD_REQUEST':
        message = 'Bad request. Please try again.';
        break;
      case 'UNAUTHORIZED':
        message = 'Unauthorized access. Please login again.';
        break;
      case 'INTERNAL_SERVER_ERROR':
        message = 'Server error. Please try later.';
        break;
      case 'NOT_FOUND':
        message = 'Requested resource not found.';
      case 'DEVICE_BANNED':
        message = 'This device is banned.';
        break;
      case 'APP_UPDATE_REQUIRED':
        message = 'Please update the application.';
        break;
      case 'REGISTRATION_FAILED':
        message = 'Registration failed.';
        break;

      default:
        message = message.isEmpty ? 'Something went wrong.' : message;
    }
    onFailure(message, code: code);
  }

  // ==========================================================
  // ✅ HTTP ERROR HANDLER
  // ==========================================================
  void _handleError(int statusCode,
      Function(String message, {String? code}) onFailure, dynamic body) {
    String message = '';
    String code = '';
    try {
      if (body is Map && body.containsKey('message')) {
        message = body['message'].toString();
      } else if (body is Map && body.containsKey('msg')) {
        message = body['msg'].toString();
        if (body.containsKey('code')) {
          code = body['code']?.toString() ?? '';
        }
      } else if (body is String) {
        message = body;
      }
    } catch (_) {
      message = '';
    }

    switch (statusCode) {
      case 400:
        message = message.isEmpty ? 'Bad Request' : message;
        code = code.isEmpty ? 'BAD_REQUEST' : code;
        break;
      case 401:
        message =
            message.isEmpty ? 'Session expired. Please login again.' : message;
        code = code.isEmpty ? 'UNAUTHORIZED' : code;
        break;
      case 403:
        message = message.isEmpty ? 'Access denied.' : message;
        code = code.isEmpty ? 'FORBIDDEN' : code;
        break;
      case 404:
        message = message.isEmpty ? 'URL not found.' : message;
        code = code.isEmpty ? 'NOT_FOUND' : code;
        break;
      case 422:
        message = message.isEmpty ? 'Validation error.' : message;
        code = code.isEmpty ? 'VALIDATION_ERROR' : code;
        break;
      case 500:
        message = message.isEmpty ? 'Internal Server Error.' : message;
        code = code.isEmpty ? 'INTERNAL_SERVER_ERROR' : code;
        break;
      case 409:
        message = message.isEmpty ? '' : message;
        code = code.isEmpty ? '' : code;
        break;
      case 503:
        message = message.isEmpty ? 'Server maintenance in progress.' : message;
        code = code.isEmpty ? 'SERVER_MAINTENANCE' : code;
        break;
      default:
        message = message.isEmpty
            ? 'Something went wrong. Code: $statusCode'
            : '$message (Code: $statusCode)';
        code = code.isEmpty ? 'HTTP_$statusCode' : code;
    }

    // AppToast.short(message);
    // onFailure(message);
    onFailure(message, code: code);
  }
}

class _PrettyLoggerInterceptor extends Interceptor {
  final _stopwatches = <String, Stopwatch>{};
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final key = '${options.method}_${options.uri}';
    _stopwatches[key] = Stopwatch()..start();

    final log = StringBuffer()
      ..writeln('╔╣ Request ║ ${options.method}')
      ..writeln('║  ${options.uri}')
      ..writeln(
        '╚══════════════════════════════════════════════════════════════════════════════════════════╝',
      )
      ..writeln('╔ Headers');
    options.headers.forEach((k, v) => log.writeln('║  $k: $v'));
    log.writeln(
      '╚══════════════════════════════════════════════════════════════════════════════════════════╝',
    );

    if (options.data != null) {
      log.writeln('╔ Body');
      if (options.data is Map) {
        (options.data as Map).forEach((k, v) => log.writeln('║  $k: $v'));
      } else {
        log.writeln('║  ${options.data}');
      }
      log.writeln(
        '╚══════════════════════════════════════════════════════════════════════════════════════════╝',
      );
    }

    debugPrint(log.toString());
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final key = '${response.requestOptions.method}_${response.realUri}';
    final sw = _stopwatches.remove(key);
    sw?.stop();
    final duration = sw != null ? '${sw.elapsedMilliseconds}ms' : 'N/A';

    final log = StringBuffer()
      ..writeln('╔╣ Response ║ Status: ${response.statusCode} ║ ⏱ $duration')
      ..writeln('║  ${response.realUri}')
      ..writeln(
        '╚══════════════════════════════════════════════════════════════════════════════════════════╝',
      )
      ..writeln('╔ Body')
      ..writeln(_prettyJson(response.data, prefix: '║  '))
      ..writeln(
        '╚══════════════════════════════════════════════════════════════════════════════════════════╝',
      );

    debugPrint(log.toString());
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final responseData = err.response?.data;
    final key = '${err.requestOptions.method}_${err.requestOptions.uri}';
    final sw = _stopwatches.remove(key);
    sw?.stop();
    final duration = sw != null ? '${sw.elapsedMilliseconds}ms' : 'N/A';
    String backendCode = '';

    if (responseData is Map && responseData.containsKey('code')) {
      backendCode = responseData['code'].toString();
    }

    final log = StringBuffer()
      ..writeln(
        '╔╣ DioError ║ HTTP: ${err.response?.statusCode ?? 'N/A'} | ⏱ $duration | Backend: $backendCode | ${err.type}',
      )
      ..writeln('║  ${err.requestOptions.uri}')
      ..writeln(
        '╚══════════════════════════════════════════════════════════════════════════════════════════╝',
      )
      ..writeln('╔ Error Body')
      ..writeln(_prettyJson(responseData, prefix: '║  '))
      ..writeln(
        '╚══════════════════════════════════════════════════════════════════════════════════════════╝',
      );

    debugPrint(log.toString());

    super.onError(err, handler);
  }

  String _prettyJson(dynamic data, {String prefix = ''}) {
    if (data == null) return '${prefix}No data';
    try {
      const encoder = JsonEncoder.withIndent('  ');
      final formatted = encoder.convert(data);
      return formatted.split('\n').map((line) => '$prefix$line').join('\n');
    } catch (_) {
      return '$prefix${data.toString()}';
    }
  }
}
