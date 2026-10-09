import 'dart:developer';

import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

/// Reference repository (_standards/04): maps API responses to models,
/// logs and rethrows errors.
class ItemRepository {
  ItemRepository({ItemApiProvider? apiProvider})
    : _apiProvider =
          apiProvider ??
          (Environment.hasBackend ? ItemApiProvider() : DemoItemApiProvider());

  final ItemApiProvider _apiProvider;

  Future<PaginatedList<Item>?> fetchItems(
    int pageKey, {
    String? keyword,
    int? size,
  }) async {
    try {
      final res = await _apiProvider.fetchItems(
        pageKey,
        keyword: keyword,
        size: size,
      );
      if (res.success && res.data != null) {
        return PaginatedList(
          pagination: res.data!.pagination,
          content: res.data!.content.map(Item.fromJson).toList(),
        );
      }
      return null;
    } catch (e) {
      log('Error fetching items: $e');
      rethrow;
    }
  }
}
