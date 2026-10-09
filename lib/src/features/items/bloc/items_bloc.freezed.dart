// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'items_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ItemsEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ItemsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ItemsEvent()';
}


}

/// @nodoc
class $ItemsEventCopyWith<$Res>  {
$ItemsEventCopyWith(ItemsEvent _, $Res Function(ItemsEvent) __);
}


/// Adds pattern-matching-related methods to [ItemsEvent].
extension ItemsEventPatterns on ItemsEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _FetchItems value)?  fetchItems,TResult Function( _RefreshItems value)?  refreshItems,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FetchItems() when fetchItems != null:
return fetchItems(_that);case _RefreshItems() when refreshItems != null:
return refreshItems(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _FetchItems value)  fetchItems,required TResult Function( _RefreshItems value)  refreshItems,}){
final _that = this;
switch (_that) {
case _FetchItems():
return fetchItems(_that);case _RefreshItems():
return refreshItems(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _FetchItems value)?  fetchItems,TResult? Function( _RefreshItems value)?  refreshItems,}){
final _that = this;
switch (_that) {
case _FetchItems() when fetchItems != null:
return fetchItems(_that);case _RefreshItems() when refreshItems != null:
return refreshItems(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int pageKey,  String? searchTerm,  int? size)?  fetchItems,TResult Function()?  refreshItems,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FetchItems() when fetchItems != null:
return fetchItems(_that.pageKey,_that.searchTerm,_that.size);case _RefreshItems() when refreshItems != null:
return refreshItems();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int pageKey,  String? searchTerm,  int? size)  fetchItems,required TResult Function()  refreshItems,}) {final _that = this;
switch (_that) {
case _FetchItems():
return fetchItems(_that.pageKey,_that.searchTerm,_that.size);case _RefreshItems():
return refreshItems();}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int pageKey,  String? searchTerm,  int? size)?  fetchItems,TResult? Function()?  refreshItems,}) {final _that = this;
switch (_that) {
case _FetchItems() when fetchItems != null:
return fetchItems(_that.pageKey,_that.searchTerm,_that.size);case _RefreshItems() when refreshItems != null:
return refreshItems();case _:
  return null;

}
}

}

/// @nodoc


class _FetchItems implements ItemsEvent {
  const _FetchItems({this.pageKey = 0, this.searchTerm, this.size});
  

@JsonKey() final  int pageKey;
 final  String? searchTerm;
 final  int? size;

/// Create a copy of ItemsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FetchItemsCopyWith<_FetchItems> get copyWith => __$FetchItemsCopyWithImpl<_FetchItems>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchItems&&(identical(other.pageKey, pageKey) || other.pageKey == pageKey)&&(identical(other.searchTerm, searchTerm) || other.searchTerm == searchTerm)&&(identical(other.size, size) || other.size == size));
}


@override
int get hashCode {
    return Object.hash(runtimeType,pageKey,searchTerm,size);
}

@override
String toString() {
    return 'ItemsEvent.fetchItems(pageKey: $pageKey, searchTerm: $searchTerm, size: $size)';
}


}

/// @nodoc
abstract mixin class _$FetchItemsCopyWith<$Res> implements $ItemsEventCopyWith<$Res> {
  factory _$FetchItemsCopyWith(_FetchItems value, $Res Function(_FetchItems) _then) = __$FetchItemsCopyWithImpl;
@useResult
$Res call({
 int pageKey, String? searchTerm, int? size
});




}
/// @nodoc
class __$FetchItemsCopyWithImpl<$Res>
    implements _$FetchItemsCopyWith<$Res> {
  __$FetchItemsCopyWithImpl(this._self, this._then);

  final _FetchItems _self;
  final $Res Function(_FetchItems) _then;

/// Create a copy of ItemsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? pageKey = null,Object? searchTerm = freezed,Object? size = freezed,}) {
  return _then(_FetchItems(
pageKey: null == pageKey ? _self.pageKey : pageKey // ignore: cast_nullable_to_non_nullable
as int,searchTerm: freezed == searchTerm ? _self.searchTerm : searchTerm // ignore: cast_nullable_to_non_nullable
as String?,size: freezed == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class _RefreshItems implements ItemsEvent {
  const _RefreshItems();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefreshItems);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ItemsEvent.refreshItems()';
}


}




/// @nodoc
mixin _$ItemsState {

 List<Item> get items; List<Item> get paginatedItems; bool get maxItems; bool get itemsRefreshController; int get itemsPageKey; GenericStatus get itemsListStatus; String? get itemsListError;
/// Create a copy of ItemsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ItemsStateCopyWith<ItemsState> get copyWith => _$ItemsStateCopyWithImpl<ItemsState>(this as ItemsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ItemsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ItemsState&&const DeepCollectionEquality().equals(other.items, _this.items)&&const DeepCollectionEquality().equals(other.paginatedItems, _this.paginatedItems)&&(identical(other.maxItems, _this.maxItems) || other.maxItems == _this.maxItems)&&(identical(other.itemsRefreshController, _this.itemsRefreshController) || other.itemsRefreshController == _this.itemsRefreshController)&&(identical(other.itemsPageKey, _this.itemsPageKey) || other.itemsPageKey == _this.itemsPageKey)&&(identical(other.itemsListStatus, _this.itemsListStatus) || other.itemsListStatus == _this.itemsListStatus)&&(identical(other.itemsListError, _this.itemsListError) || other.itemsListError == _this.itemsListError));
}


@override
int get hashCode {
  final _this = this as ItemsState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.items),const DeepCollectionEquality().hash(_this.paginatedItems),_this.maxItems,_this.itemsRefreshController,_this.itemsPageKey,_this.itemsListStatus,_this.itemsListError);
}

@override
String toString() {
  final _this = this as ItemsState;
  return 'ItemsState(items: ${_this.items}, paginatedItems: ${_this.paginatedItems}, maxItems: ${_this.maxItems}, itemsRefreshController: ${_this.itemsRefreshController}, itemsPageKey: ${_this.itemsPageKey}, itemsListStatus: ${_this.itemsListStatus}, itemsListError: ${_this.itemsListError})';
}


}

/// @nodoc
abstract mixin class $ItemsStateCopyWith<$Res>  {
  factory $ItemsStateCopyWith(ItemsState value, $Res Function(ItemsState) _then) = _$ItemsStateCopyWithImpl;
@useResult
$Res call({
 List<Item> items, List<Item> paginatedItems, bool maxItems, bool itemsRefreshController, int itemsPageKey, GenericStatus itemsListStatus, String? itemsListError
});




}
/// @nodoc
class _$ItemsStateCopyWithImpl<$Res>
    implements $ItemsStateCopyWith<$Res> {
  _$ItemsStateCopyWithImpl(this._self, this._then);

  final ItemsState _self;
  final $Res Function(ItemsState) _then;

/// Create a copy of ItemsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? paginatedItems = null,Object? maxItems = null,Object? itemsRefreshController = null,Object? itemsPageKey = null,Object? itemsListStatus = null,Object? itemsListError = freezed,}) {
  return _then(ItemsState(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<Item>,paginatedItems: null == paginatedItems ? _self.paginatedItems : paginatedItems // ignore: cast_nullable_to_non_nullable
as List<Item>,maxItems: null == maxItems ? _self.maxItems : maxItems // ignore: cast_nullable_to_non_nullable
as bool,itemsRefreshController: null == itemsRefreshController ? _self.itemsRefreshController : itemsRefreshController // ignore: cast_nullable_to_non_nullable
as bool,itemsPageKey: null == itemsPageKey ? _self.itemsPageKey : itemsPageKey // ignore: cast_nullable_to_non_nullable
as int,itemsListStatus: null == itemsListStatus ? _self.itemsListStatus : itemsListStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,itemsListError: freezed == itemsListError ? _self.itemsListError : itemsListError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ItemsState].
extension ItemsStatePatterns on ItemsState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ItemsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ItemsState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ItemsState value)  $default,){
final _that = this;
switch (_that) {
case _ItemsState():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ItemsState value)?  $default,){
final _that = this;
switch (_that) {
case _ItemsState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Item> items,  List<Item> paginatedItems,  bool maxItems,  bool itemsRefreshController,  int itemsPageKey,  GenericStatus itemsListStatus,  String? itemsListError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ItemsState() when $default != null:
return $default(_that.items,_that.paginatedItems,_that.maxItems,_that.itemsRefreshController,_that.itemsPageKey,_that.itemsListStatus,_that.itemsListError);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Item> items,  List<Item> paginatedItems,  bool maxItems,  bool itemsRefreshController,  int itemsPageKey,  GenericStatus itemsListStatus,  String? itemsListError)  $default,) {final _that = this;
switch (_that) {
case _ItemsState():
return $default(_that.items,_that.paginatedItems,_that.maxItems,_that.itemsRefreshController,_that.itemsPageKey,_that.itemsListStatus,_that.itemsListError);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Item> items,  List<Item> paginatedItems,  bool maxItems,  bool itemsRefreshController,  int itemsPageKey,  GenericStatus itemsListStatus,  String? itemsListError)?  $default,) {final _that = this;
switch (_that) {
case _ItemsState() when $default != null:
return $default(_that.items,_that.paginatedItems,_that.maxItems,_that.itemsRefreshController,_that.itemsPageKey,_that.itemsListStatus,_that.itemsListError);case _:
  return null;

}
}

}

/// @nodoc


class _ItemsState implements ItemsState {
  const _ItemsState({ List<Item> items = const [],  List<Item> paginatedItems = const [], this.maxItems = false, this.itemsRefreshController = false, this.itemsPageKey = 0, this.itemsListStatus = GenericStatus.initial, this.itemsListError}): _items = items,_paginatedItems = paginatedItems;
  

 final  List<Item> _items;
@override@JsonKey() List<Item> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

 final  List<Item> _paginatedItems;
@override@JsonKey() List<Item> get paginatedItems {
  if (_paginatedItems is EqualUnmodifiableListView) return _paginatedItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_paginatedItems);
}

@override@JsonKey() final  bool maxItems;
@override@JsonKey() final  bool itemsRefreshController;
@override@JsonKey() final  int itemsPageKey;
@override@JsonKey() final  GenericStatus itemsListStatus;
@override final  String? itemsListError;

/// Create a copy of ItemsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ItemsStateCopyWith<_ItemsState> get copyWith => __$ItemsStateCopyWithImpl<_ItemsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ItemsState&&const DeepCollectionEquality().equals(other.items, _items)&&const DeepCollectionEquality().equals(other.paginatedItems, _paginatedItems)&&(identical(other.maxItems, maxItems) || other.maxItems == maxItems)&&(identical(other.itemsRefreshController, itemsRefreshController) || other.itemsRefreshController == itemsRefreshController)&&(identical(other.itemsPageKey, itemsPageKey) || other.itemsPageKey == itemsPageKey)&&(identical(other.itemsListStatus, itemsListStatus) || other.itemsListStatus == itemsListStatus)&&(identical(other.itemsListError, itemsListError) || other.itemsListError == itemsListError));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),const DeepCollectionEquality().hash(_paginatedItems),maxItems,itemsRefreshController,itemsPageKey,itemsListStatus,itemsListError);
}

@override
String toString() {
    return 'ItemsState(items: $items, paginatedItems: $paginatedItems, maxItems: $maxItems, itemsRefreshController: $itemsRefreshController, itemsPageKey: $itemsPageKey, itemsListStatus: $itemsListStatus, itemsListError: $itemsListError)';
}


}

/// @nodoc
abstract mixin class _$ItemsStateCopyWith<$Res> implements $ItemsStateCopyWith<$Res> {
  factory _$ItemsStateCopyWith(_ItemsState value, $Res Function(_ItemsState) _then) = __$ItemsStateCopyWithImpl;
@override @useResult
$Res call({
 List<Item> items, List<Item> paginatedItems, bool maxItems, bool itemsRefreshController, int itemsPageKey, GenericStatus itemsListStatus, String? itemsListError
});




}
/// @nodoc
class __$ItemsStateCopyWithImpl<$Res>
    implements _$ItemsStateCopyWith<$Res> {
  __$ItemsStateCopyWithImpl(this._self, this._then);

  final _ItemsState _self;
  final $Res Function(_ItemsState) _then;

/// Create a copy of ItemsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? paginatedItems = null,Object? maxItems = null,Object? itemsRefreshController = null,Object? itemsPageKey = null,Object? itemsListStatus = null,Object? itemsListError = freezed,}) {
  return _then(_ItemsState(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<Item>,paginatedItems: null == paginatedItems ? _self._paginatedItems : paginatedItems // ignore: cast_nullable_to_non_nullable
as List<Item>,maxItems: null == maxItems ? _self.maxItems : maxItems // ignore: cast_nullable_to_non_nullable
as bool,itemsRefreshController: null == itemsRefreshController ? _self.itemsRefreshController : itemsRefreshController // ignore: cast_nullable_to_non_nullable
as bool,itemsPageKey: null == itemsPageKey ? _self.itemsPageKey : itemsPageKey // ignore: cast_nullable_to_non_nullable
as int,itemsListStatus: null == itemsListStatus ? _self.itemsListStatus : itemsListStatus // ignore: cast_nullable_to_non_nullable
as GenericStatus,itemsListError: freezed == itemsListError ? _self.itemsListError : itemsListError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
