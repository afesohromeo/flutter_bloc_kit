import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';
import 'package:flutter_test/flutter_test.dart';

DioException _error({
  int? status,
  Object? body,
  DioExceptionType type = DioExceptionType.badResponse,
}) {
  final options = RequestOptions(path: '/items');
  return DioException(
    requestOptions: options,
    type: type,
    response: status == null
        ? null
        : Response(requestOptions: options, statusCode: status, data: body),
  );
}

void main() {
  group('Given ApiErrorHandler.handle', () {
    test('when the server answers 400 then it keeps the server message', () {
      final result = ApiErrorHandler.handle(
        _error(status: 400, body: {'message': 'Name already used'}),
      );

      expect(result, isA<HttpException400>());
      expect((result as HttpException400).message, 'Name already used');
      expect(result.statusCode, 400);
    });

    test('when another 4xx arrives then it is treated like a 400', () {
      final result = ApiErrorHandler.handle(
        _error(status: 409, body: {'error': 'Conflict on item'}),
      );

      expect(result, isA<HttpException400>());
      expect((result as HttpException400).message, 'Conflict on item');
    });

    test('when the body is raw JSON text then it still finds the message', () {
      final result = ApiErrorHandler.handle(
        _error(status: 422, body: jsonEncode({'detail': 'Invalid date'})),
      );

      expect((result as HttpException400).message, 'Invalid date');
    });

    test('when the body is UTF-8 bytes then it still finds the message', () {
      final result = ApiErrorHandler.handle(
        _error(status: 400, body: utf8.encode('{"message":"Prix invalide"}')),
      );

      expect((result as HttpException400).message, 'Prix invalide');
    });

    test('when the body has no message then the message is null', () {
      final result = ApiErrorHandler.handle(_error(status: 400, body: ''));

      expect((result as HttpException400).message, isNull);
    });

    test('when the server answers 401 then it signals an ended session', () {
      expect(
        ApiErrorHandler.handle(_error(status: 401)),
        isA<HttpException401>(),
      );
    });

    test('when the server answers 410 then it signals a gone resource', () {
      expect(
        ApiErrorHandler.handle(_error(status: 410)),
        isA<HttpException410>(),
      );
    });

    test('when the server fails with 5xx then it is a network problem', () {
      expect(
        ApiErrorHandler.handle(_error(status: 503)),
        isA<NetworkException>(),
      );
    });

    test(
      'when the connection times out or fails then it is a network problem',
      () {
        for (final type in [
          DioExceptionType.connectionTimeout,
          DioExceptionType.receiveTimeout,
          DioExceptionType.sendTimeout,
          DioExceptionType.connectionError,
        ]) {
          expect(
            ApiErrorHandler.handle(_error(type: type)),
            isA<NetworkException>(),
            reason: '$type',
          );
        }
      },
    );
  });
}
