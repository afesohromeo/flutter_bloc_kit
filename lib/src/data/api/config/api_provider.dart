import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

/// Holds the app's single [Dio] client. API providers read it with
/// `Dio get _dio => ApiProvider().dio;` (_standards/04).
///
/// Call [initialize] once in `AppInitializer.preAppRun()`; until then a
/// client without an [DioInterceptor.onUnauthorized] callback is used.
class ApiProvider {
  ApiProvider._internal();

  static final ApiProvider _instance = ApiProvider._internal();

  factory ApiProvider() => _instance;

  Dio? _dio;

  Dio get dio => _dio ??= _createDio();

  @visibleForTesting
  set dio(Dio value) => _dio = value;

  void initialize({VoidCallback? onUnauthorized}) {
    _dio = _createDio(onUnauthorized: onUnauthorized);
  }

  static Dio _createDio({VoidCallback? onUnauthorized}) {
    return Dio(
      BaseOptions(
        baseUrl: Environment.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    )..interceptors.add(DioInterceptor(onUnauthorized: onUnauthorized));
  }
}
