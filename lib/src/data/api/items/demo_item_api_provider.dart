import 'dart:math';

import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

/// **Kit demo only.** Serves generated items, page by page and searchable,
/// when the app runs without `BASE_URL`, so the reference feature works
/// without a backend. Delete it together with the `items` feature.
class DemoItemApiProvider extends ItemApiProvider {
  DemoItemApiProvider({this.delay = const Duration(milliseconds: 400)});

  static const itemCount = 45;

  /// Simulated network latency, so loading states are visible.
  final Duration delay;

  @override
  Future<AppApiResponse> fetchItems(
    int pageKey, {
    String? keyword,
    int? size,
  }) async {
    await Future<void>.delayed(delay);
    final pageSize = size ?? 20;
    final query = keyword?.trim().toLowerCase() ?? '';

    final matching = [
      for (var id = 1; id <= itemCount; id++) {'id': id, 'name': 'Item $id'},
    ].where((json) => (json['name'] as String).toLowerCase().contains(query));
    final all = matching.toList();

    final start = pageKey * pageSize;
    final content = start >= all.length
        ? <Map<String, dynamic>>[]
        : all.sublist(start, min(start + pageSize, all.length));

    return AppApiResponse.fromJson({
      'success': true,
      'message': '',
      'data': {
        'content': content,
        'totalElements': all.length,
        'totalPages': (all.length / pageSize).ceil(),
        'size': pageSize,
      },
    });
  }
}
