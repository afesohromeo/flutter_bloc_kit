import 'dart:convert';

import 'package:dio/dio.dart';

/// The server rejected the request (any 4xx except 401 and 410).
/// [message] is the server's explanation, when it sent one.
class HttpException400 implements Exception {
  const HttpException400(this.message, {this.statusCode});

  final String? message;
  final int? statusCode;

  @override
  String toString() => message ?? 'HttpException400($statusCode)';
}

/// 401: not signed in, or the session expired.
class HttpException401 implements Exception {
  const HttpException401([this.message]);

  final String? message;

  @override
  String toString() => message ?? 'HttpException401';
}

/// 410: the resource or account is permanently gone.
class HttpException410 implements Exception {
  const HttpException410([this.message]);

  final String? message;

  @override
  String toString() => message ?? 'HttpException410';
}

/// No connection, a timeout, or the server failed (5xx).
class NetworkException implements Exception {
  const NetworkException([this.message]);

  final String? message;

  @override
  String toString() => message ?? 'NetworkException';
}

/// Turns a [DioException] into one of the typed exceptions above, which
/// repositories rethrow and BLoCs catch (_standards/04).
class ApiErrorHandler {
  ApiErrorHandler._();

  static Exception handle(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return const NetworkException();
      default:
        break;
    }

    final statusCode = e.response?.statusCode;
    final message = _extractMessage(e.response?.data);

    if (statusCode == 401) return HttpException401(message);
    if (statusCode == 410) return HttpException410(message);
    if (statusCode != null && statusCode >= 400 && statusCode < 500) {
      return HttpException400(message, statusCode: statusCode);
    }
    return NetworkException(message);
  }

  /// The `message`, `error` or `detail` field of a JSON error body, whether
  /// it arrives decoded, as text, or as UTF-8 bytes.
  static String? _extractMessage(Object? data) {
    Object? body = data;
    if (body is List<int>) body = utf8.decode(body, allowMalformed: true);
    if (body is String) {
      if (body.trim().isEmpty) return null;
      try {
        body = jsonDecode(body);
      } on FormatException {
        return body as String;
      }
    }
    if (body is Map) {
      final value = body['message'] ?? body['error'] ?? body['detail'];
      final text = value?.toString();
      return (text == null || text.isEmpty) ? null : text;
    }
    return null;
  }
}
