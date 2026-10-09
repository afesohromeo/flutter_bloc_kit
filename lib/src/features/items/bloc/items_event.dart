part of 'items_bloc.dart';

@freezed
sealed class ItemsEvent with _$ItemsEvent {
  /// Fetches one page; [searchTerm] is sent to the server as `keyword`.
  const factory ItemsEvent.fetchItems({
    @Default(0) int pageKey,
    String? searchTerm,
    int? size,
  }) = _FetchItems;

  const factory ItemsEvent.refreshItems() = _RefreshItems;
}
