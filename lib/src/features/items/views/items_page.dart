import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

/// Reference page for an infinite-scroll list with server-side search
/// (_standards/13). Expects an [ItemsBloc] above it (see `RouteManager`).
class ItemsPage extends StatefulWidget {
  const ItemsPage({super.key});

  static const searchFieldKey = Key('itemsPage.searchField');
  static const demoNoticeKey = Key('itemsPage.demoNotice');

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  final PagingController<int, Item> _pagingController = PagingController(
    firstPageKey: 0,
  );
  Timer? _debounce;
  String? _searchTerm;

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener(_fetchPage);
  }

  void _fetchPage(int pageKey) {
    if (!mounted) return;
    context.read<ItemsBloc>().add(
      ItemsEvent.fetchItems(pageKey: pageKey, searchTerm: _searchTerm),
    );
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      setState(() => _searchTerm = value.trim().isEmpty ? null : value.trim());
      context.read<ItemsBloc>().add(const ItemsEvent.refreshItems());
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ResponsiveScaffoldWrapper(
      props: ScaffoldWrapperProps(
        resizeToAvoidBottomInset: true,
        appBarBgColor: customColors.background,
        elevation: 0,
        showDrawer: false,
        leading: const CustomBackButton(),
        title: Text(
          l10n.itemsTitle,
          style: context.textTheme.titleLarge?.copyWith(
            color: customColors.black1,
          ),
        ),
      ),
      mobileBody: _buildBody(l10n),
    );
  }

  Widget _buildBody(AppLocalizations l10n) {
    return BlocConsumer<ItemsBloc, ItemsState>(
      listenWhen: (prev, curr) =>
          prev.itemsListStatus != curr.itemsListStatus ||
          prev.itemsRefreshController != curr.itemsRefreshController,
      listener: (context, state) {
        if (state.itemsRefreshController) {
          _pagingController.refresh();
          return;
        }
        if (state.itemsListStatus == GenericStatus.success) {
          if (state.maxItems) {
            _pagingController.appendLastPage(state.paginatedItems);
          } else {
            _pagingController.appendPage(
              state.paginatedItems,
              state.itemsPageKey + 1,
            );
          }
        } else if (state.itemsListStatus == GenericStatus.failure) {
          _pagingController.error =
              state.itemsListError ?? l10n.errorLoadingItems;
        }
      },
      buildWhen: (prev, curr) => false,
      builder: (context, state) => RefreshIndicator(
        onRefresh: () async =>
            context.read<ItemsBloc>().add(const ItemsEvent.refreshItems()),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!Environment.hasBackend) ...[
                const Gap.vertical(height: 8),
                Text(
                  l10n.itemsDemoNotice,
                  key: ItemsPage.demoNoticeKey,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: customColors.surface,
                  ),
                ),
              ],
              const Gap.vertical(height: 12),
              SearchInputField(
                key: ItemsPage.searchFieldKey,
                onChanged: _onSearchChanged,
                labelText: l10n.itemsSearchHint,
              ),
              const Gap.vertical(height: 12),
              Expanded(
                child: CustomPaginatedList<Item>(
                  pagingController: _pagingController,
                  seperator: const Gap.vertical(height: 8),
                  pagedChildBuilderDelegate: PagedChildBuilderDelegate<Item>(
                    itemBuilder: (context, item, index) => ItemCard(item: item),
                    firstPageProgressIndicatorBuilder: (_) =>
                        const _ItemsSkeleton(),
                    newPageProgressIndicatorBuilder: (_) => const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    ),
                    firstPageErrorIndicatorBuilder: (_) => ErrorStateWidget(
                      errorMessage:
                          _pagingController.error?.toString() ??
                          l10n.errorLoadingItems,
                      onPressed: () => context.read<ItemsBloc>().add(
                        const ItemsEvent.refreshItems(),
                      ),
                    ),
                    newPageErrorIndicatorBuilder: (_) => ErrorStateWidget(
                      errorMessage:
                          _pagingController.error?.toString() ??
                          l10n.errorLoadingItems,
                      onPressed: _pagingController.retryLastFailedRequest,
                    ),
                    noItemsFoundIndicatorBuilder: (_) => EmptyWidget(
                      emptyText: _searchTerm != null
                          ? l10n.itemsSearchEmptyState
                          : l10n.itemsEmptyState,
                      onPressed: () => context.read<ItemsBloc>().add(
                        const ItemsEvent.refreshItems(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Placeholder rows shaped like [ItemCard], shown during the first load.
class _ItemsSkeleton extends StatelessWidget {
  const _ItemsSkeleton();

  @override
  Widget build(BuildContext context) {
    return ShimmerSkeleton(
      child: Column(
        children: [
          for (var i = 0; i < 6; i++)
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: SkeletonBox(height: 56, radius: 12),
            ),
        ],
      ),
    );
  }
}
