import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';
import 'package:intl/intl.dart';

/// Adds the auth token and the app language to every request, logs traffic
/// in debug builds only, and reports 401 answers through [onUnauthorized].
class DioInterceptor extends Interceptor {
  DioInterceptor({this.onUnauthorized, Future<String?> Function()? readToken})
    : _readToken = readToken ?? SecureStorageHelper.getToken;

  /// Called when the server answers 401 (e.g. to sign the user out).
  final VoidCallback? onUnauthorized;
  final Future<String?> Function() _readToken;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _readToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.headers['Accept-Language'] = Intl.shortLocale(
      Intl.getCurrentLocale(),
    );
    if (kDebugMode) {
      log('→ ${options.method} ${options.uri}\n${options.data ?? ''}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      log(
        '← ${response.statusCode} ${response.requestOptions.uri}\n'
        '${response.data}',
      );
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      log(
        '✗ ${err.response?.statusCode ?? err.type.name} '
        '${err.requestOptions.uri}\n${err.response?.data ?? err.message}',
      );
    }
    if (err.response?.statusCode == 401) onUnauthorized?.call();
    handler.next(err);
  }
}
