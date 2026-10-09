import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

/// What repositories return for a page of a list (_standards/04, 13).
class PaginatedList<T> {
  const PaginatedList({required this.pagination, required this.content});

  final Pagination pagination;
  final List<T> content;
}
