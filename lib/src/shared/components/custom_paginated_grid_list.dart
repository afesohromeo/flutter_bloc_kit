import 'package:flutter/widgets.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CustomPaginatedGridList<T> extends StatelessWidget {
  const CustomPaginatedGridList(
      {super.key,
      required this.pagingController,
      required this.pagedChildBuilderDelegate,
      required this.gridDelegate,
      this.pageKey,
      this.wrap = false,
      this.physics});
  final PagingController<int, T> pagingController;
  final PagedChildBuilderDelegate<T> pagedChildBuilderDelegate;
  final SliverGridDelegate gridDelegate;
  final PageStorageKey? pageKey;
  final bool wrap;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return PagedGridView<int, T>(
      physics: physics,
      shrinkWrap: wrap,
      pagingController: pagingController,
      gridDelegate: gridDelegate,
      builderDelegate: pagedChildBuilderDelegate,
      // key: pageKey,
    );
  }
}

// typedef FetchPageCallback<T> = Future<List<T>> Function(int pageKey);
