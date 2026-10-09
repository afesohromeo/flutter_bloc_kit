import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'items_event.dart';
part 'items_state.dart';
part 'items_bloc.freezed.dart';

const _kItemsPageSize = 20;

/// Reference BLoC for an infinite-scroll list (_standards/13).
class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  ItemsBloc({required ItemRepository repository})
    : _repository = repository,
      super(const ItemsState()) {
    on<_FetchItems>(_onFetchItems);
    on<_RefreshItems>(_onRefreshItems);
  }

  final ItemRepository _repository;

  Future<void> _onFetchItems(
    _FetchItems event,
    Emitter<ItemsState> emit,
  ) async {
    final l10n = LocalizationService.localization;
    final pageSize = event.size ?? _kItemsPageSize;

    // STEP 1: loading (or filtering), and reset the refresh controller.
    emit(
      state.copyWith(
        itemsListStatus: event.searchTerm != null
            ? GenericStatus.filtering
            : GenericStatus.loading,
        itemsListError: null,
        items: event.pageKey == 0 ? [] : state.items,
        itemsRefreshController: false,
      ),
    );

    try {
      // STEP 2: call the repository; search runs on the server.
      final result = await _repository.fetchItems(
        event.pageKey,
        keyword: event.searchTerm,
        size: pageSize,
      );

      // STEP 4: no result.
      if (result == null) {
        emit(
          state.copyWith(
            itemsListStatus: GenericStatus.failure,
            itemsListError: l10n.errorLoadingItems,
          ),
        );
        return;
      }

      // STEP 3: success. The last page is shorter than the page size the
      // server actually used.
      final newItems = result.content;
      emit(
        state.copyWith(
          itemsListStatus: GenericStatus.success,
          paginatedItems: newItems,
          maxItems: newItems.length < (result.pagination.size ?? pageSize),
          itemsPageKey: event.pageKey,
          items: event.pageKey == 0 ? newItems : [...state.items, ...newItems],
        ),
      );
    } on HttpException400 catch (e) {
      // STEP 5: typed errors, then everything else.
      emit(
        state.copyWith(
          itemsListStatus: GenericStatus.failure,
          itemsListError: e.message ?? l10n.errorLoadingItems,
        ),
      );
    } on HttpException401 {
      emit(
        state.copyWith(
          itemsListStatus: GenericStatus.failure,
          itemsListError: l10n.errorUnauthorized,
        ),
      );
    } on NetworkException {
      emit(
        state.copyWith(
          itemsListStatus: GenericStatus.failure,
          itemsListError: l10n.networkError,
        ),
      );
    } catch (e) {
      log('ItemsBloc._onFetchItems error: $e');
      emit(
        state.copyWith(
          itemsListStatus: GenericStatus.failure,
          itemsListError: l10n.errorLoadingItems,
        ),
      );
    }
  }

  /// Clears the list and flips the controller; the page then refreshes its
  /// PagingController, which requests page 0 again.
  void _onRefreshItems(_RefreshItems event, Emitter<ItemsState> emit) {
    emit(
      state.copyWith(
        itemsListStatus: GenericStatus.initial,
        items: [],
        paginatedItems: [],
        itemsPageKey: 0,
        maxItems: false,
        itemsRefreshController: true,
      ),
    );
  }
}
