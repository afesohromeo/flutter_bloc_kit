import 'package:dio/dio.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

/// Reference API provider (_standards/04): HTTP only, no business logic.
class ItemApiProvider {
  Dio get _dio => ApiProvider().dio;

  Future<AppApiResponse> fetchItems(
    int pageKey, {
    String? keyword,
    int? size,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/items',
        queryParameters: {
          'page': pageKey,
          'size': size ?? 20,
          'keyword': keyword,
          'sort': 'DESC',
        }..removeWhere((key, value) => value == null),
      );
      return AppApiResponse.fromJson(response.data ?? const {});
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }
}
