import 'package:dio/dio.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

class _RequestHandler extends RequestInterceptorHandler {
  RequestOptions? passed;

  @override
  void next(RequestOptions requestOptions) => passed = requestOptions;
}

class _ErrorHandler extends ErrorInterceptorHandler {
  DioException? passed;

  @override
  void next(DioException error) => passed = error;
}

DioException _errorWithStatus(int status) {
  final options = RequestOptions(path: '/items');
  return DioException(
    requestOptions: options,
    type: DioExceptionType.badResponse,
    response: Response(requestOptions: options, statusCode: status),
  );
}

void main() {
  setUp(() => Intl.defaultLocale = 'fr');
  tearDown(() => Intl.defaultLocale = null);

  group('Given the Dio interceptor', () {
    test(
      'when a token is saved then requests carry it as a bearer token',
      () async {
        final interceptor = DioInterceptor(readToken: () async => 'abc');
        final handler = _RequestHandler();

        await interceptor.onRequest(RequestOptions(path: '/items'), handler);

        expect(handler.passed!.headers['Authorization'], 'Bearer abc');
      },
    );

    test('when no token is saved then requests have no auth header', () async {
      final interceptor = DioInterceptor(readToken: () async => null);
      final handler = _RequestHandler();

      await interceptor.onRequest(RequestOptions(path: '/items'), handler);

      expect(handler.passed!.headers.containsKey('Authorization'), isFalse);
    });

    test('when a request leaves then it carries the app language', () async {
      final interceptor = DioInterceptor(readToken: () async => null);
      final handler = _RequestHandler();

      await interceptor.onRequest(RequestOptions(path: '/items'), handler);

      expect(handler.passed!.headers['Accept-Language'], 'fr');
    });

    test('when the server answers 401 then onUnauthorized is called', () {
      var calls = 0;
      final interceptor = DioInterceptor(onUnauthorized: () => calls++);
      final handler = _ErrorHandler();

      interceptor.onError(_errorWithStatus(401), handler);

      expect(calls, 1);
      expect(handler.passed, isNotNull);
    });

    test('when another error arrives then onUnauthorized is not called', () {
      var calls = 0;
      final interceptor = DioInterceptor(onUnauthorized: () => calls++);

      interceptor.onError(_errorWithStatus(500), _ErrorHandler());

      expect(calls, 0);
    });
  });
}
