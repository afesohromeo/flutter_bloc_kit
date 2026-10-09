part of 'items_bloc.dart';

@freezed
sealed class ItemsState with _$ItemsState {
  const factory ItemsState({
    // --- Items (infinite-scroll pagination, _standards/13) ---
    @Default([]) List<Item> items,
    @Default([]) List<Item> paginatedItems,
    @Default(false) bool maxItems,
    @Default(false) bool itemsRefreshController,
    @Default(0) int itemsPageKey,
    @Default(GenericStatus.initial) GenericStatus itemsListStatus,
    String? itemsListError,
  }) = _ItemsState;
}
