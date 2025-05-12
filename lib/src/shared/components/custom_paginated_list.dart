import 'package:flutter/widgets.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CustomPaginatedList<T> extends StatelessWidget {
  const CustomPaginatedList(
      {super.key,
      required this.pagingController,
      required this.pagedChildBuilderDelegate,
      this.pageKey,
      this.wrap = false,
      this.seperator = const SizedBox.shrink(),
      this.physics});
  final PagingController<int, T> pagingController;
  final PagedChildBuilderDelegate<T> pagedChildBuilderDelegate;
  final PageStorageKey? pageKey;
  final bool wrap;
  final Widget seperator;

  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, T>.separated(
      physics: physics,
      shrinkWrap: wrap,
      pagingController: pagingController,
      builderDelegate: pagedChildBuilderDelegate,
      separatorBuilder: (BuildContext context, int index) {
        return seperator;
      },
    );
  }
}

typedef FetchPageCallback<T> = Future<List<T>> Function(int pageKey);
