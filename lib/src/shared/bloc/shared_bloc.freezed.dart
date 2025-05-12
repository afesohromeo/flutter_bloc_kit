// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shared_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SharedEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialized,
    required TResult Function(DateTime dateFrom, DateTime dateTo) datesUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialized,
    TResult? Function(DateTime dateFrom, DateTime dateTo)? datesUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialized,
    TResult Function(DateTime dateFrom, DateTime dateTo)? datesUpdated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initialized value) initialized,
    required TResult Function(_DatesUpdated value) datesUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initialized value)? initialized,
    TResult? Function(_DatesUpdated value)? datesUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initialized value)? initialized,
    TResult Function(_DatesUpdated value)? datesUpdated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SharedEventCopyWith<$Res> {
  factory $SharedEventCopyWith(
          SharedEvent value, $Res Function(SharedEvent) then) =
      _$SharedEventCopyWithImpl<$Res, SharedEvent>;
}

/// @nodoc
class _$SharedEventCopyWithImpl<$Res, $Val extends SharedEvent>
    implements $SharedEventCopyWith<$Res> {
  _$SharedEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SharedEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitializedImplCopyWith<$Res> {
  factory _$$InitializedImplCopyWith(
          _$InitializedImpl value, $Res Function(_$InitializedImpl) then) =
      __$$InitializedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitializedImplCopyWithImpl<$Res>
    extends _$SharedEventCopyWithImpl<$Res, _$InitializedImpl>
    implements _$$InitializedImplCopyWith<$Res> {
  __$$InitializedImplCopyWithImpl(
      _$InitializedImpl _value, $Res Function(_$InitializedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SharedEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitializedImpl implements _Initialized {
  const _$InitializedImpl();

  @override
  String toString() {
    return 'SharedEvent.initialized()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitializedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialized,
    required TResult Function(DateTime dateFrom, DateTime dateTo) datesUpdated,
  }) {
    return initialized();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialized,
    TResult? Function(DateTime dateFrom, DateTime dateTo)? datesUpdated,
  }) {
    return initialized?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialized,
    TResult Function(DateTime dateFrom, DateTime dateTo)? datesUpdated,
    required TResult orElse(),
  }) {
    if (initialized != null) {
      return initialized();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initialized value) initialized,
    required TResult Function(_DatesUpdated value) datesUpdated,
  }) {
    return initialized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initialized value)? initialized,
    TResult? Function(_DatesUpdated value)? datesUpdated,
  }) {
    return initialized?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initialized value)? initialized,
    TResult Function(_DatesUpdated value)? datesUpdated,
    required TResult orElse(),
  }) {
    if (initialized != null) {
      return initialized(this);
    }
    return orElse();
  }
}

abstract class _Initialized implements SharedEvent {
  const factory _Initialized() = _$InitializedImpl;
}

/// @nodoc
abstract class _$$DatesUpdatedImplCopyWith<$Res> {
  factory _$$DatesUpdatedImplCopyWith(
          _$DatesUpdatedImpl value, $Res Function(_$DatesUpdatedImpl) then) =
      __$$DatesUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime dateFrom, DateTime dateTo});
}

/// @nodoc
class __$$DatesUpdatedImplCopyWithImpl<$Res>
    extends _$SharedEventCopyWithImpl<$Res, _$DatesUpdatedImpl>
    implements _$$DatesUpdatedImplCopyWith<$Res> {
  __$$DatesUpdatedImplCopyWithImpl(
      _$DatesUpdatedImpl _value, $Res Function(_$DatesUpdatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SharedEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateFrom = null,
    Object? dateTo = null,
  }) {
    return _then(_$DatesUpdatedImpl(
      dateFrom: null == dateFrom
          ? _value.dateFrom
          : dateFrom // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dateTo: null == dateTo
          ? _value.dateTo
          : dateTo // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$DatesUpdatedImpl implements _DatesUpdated {
  const _$DatesUpdatedImpl({required this.dateFrom, required this.dateTo});

  @override
  final DateTime dateFrom;
  @override
  final DateTime dateTo;

  @override
  String toString() {
    return 'SharedEvent.datesUpdated(dateFrom: $dateFrom, dateTo: $dateTo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DatesUpdatedImpl &&
            (identical(other.dateFrom, dateFrom) ||
                other.dateFrom == dateFrom) &&
            (identical(other.dateTo, dateTo) || other.dateTo == dateTo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, dateFrom, dateTo);

  /// Create a copy of SharedEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DatesUpdatedImplCopyWith<_$DatesUpdatedImpl> get copyWith =>
      __$$DatesUpdatedImplCopyWithImpl<_$DatesUpdatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialized,
    required TResult Function(DateTime dateFrom, DateTime dateTo) datesUpdated,
  }) {
    return datesUpdated(dateFrom, dateTo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialized,
    TResult? Function(DateTime dateFrom, DateTime dateTo)? datesUpdated,
  }) {
    return datesUpdated?.call(dateFrom, dateTo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialized,
    TResult Function(DateTime dateFrom, DateTime dateTo)? datesUpdated,
    required TResult orElse(),
  }) {
    if (datesUpdated != null) {
      return datesUpdated(dateFrom, dateTo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initialized value) initialized,
    required TResult Function(_DatesUpdated value) datesUpdated,
  }) {
    return datesUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initialized value)? initialized,
    TResult? Function(_DatesUpdated value)? datesUpdated,
  }) {
    return datesUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initialized value)? initialized,
    TResult Function(_DatesUpdated value)? datesUpdated,
    required TResult orElse(),
  }) {
    if (datesUpdated != null) {
      return datesUpdated(this);
    }
    return orElse();
  }
}

abstract class _DatesUpdated implements SharedEvent {
  const factory _DatesUpdated(
      {required final DateTime dateFrom,
      required final DateTime dateTo}) = _$DatesUpdatedImpl;

  DateTime get dateFrom;
  DateTime get dateTo;

  /// Create a copy of SharedEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DatesUpdatedImplCopyWith<_$DatesUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SharedState {
  SharedStatus get status => throw _privateConstructorUsedError;
  DateTime? get dateFrom => throw _privateConstructorUsedError;
  DateTime? get dateTo => throw _privateConstructorUsedError;

  /// Create a copy of SharedState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SharedStateCopyWith<SharedState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SharedStateCopyWith<$Res> {
  factory $SharedStateCopyWith(
          SharedState value, $Res Function(SharedState) then) =
      _$SharedStateCopyWithImpl<$Res, SharedState>;
  @useResult
  $Res call({SharedStatus status, DateTime? dateFrom, DateTime? dateTo});
}

/// @nodoc
class _$SharedStateCopyWithImpl<$Res, $Val extends SharedState>
    implements $SharedStateCopyWith<$Res> {
  _$SharedStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SharedState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? dateFrom = freezed,
    Object? dateTo = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SharedStatus,
      dateFrom: freezed == dateFrom
          ? _value.dateFrom
          : dateFrom // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dateTo: freezed == dateTo
          ? _value.dateTo
          : dateTo // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SharedStateImplCopyWith<$Res>
    implements $SharedStateCopyWith<$Res> {
  factory _$$SharedStateImplCopyWith(
          _$SharedStateImpl value, $Res Function(_$SharedStateImpl) then) =
      __$$SharedStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SharedStatus status, DateTime? dateFrom, DateTime? dateTo});
}

/// @nodoc
class __$$SharedStateImplCopyWithImpl<$Res>
    extends _$SharedStateCopyWithImpl<$Res, _$SharedStateImpl>
    implements _$$SharedStateImplCopyWith<$Res> {
  __$$SharedStateImplCopyWithImpl(
      _$SharedStateImpl _value, $Res Function(_$SharedStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SharedState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? dateFrom = freezed,
    Object? dateTo = freezed,
  }) {
    return _then(_$SharedStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SharedStatus,
      dateFrom: freezed == dateFrom
          ? _value.dateFrom
          : dateFrom // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dateTo: freezed == dateTo
          ? _value.dateTo
          : dateTo // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$SharedStateImpl implements _SharedState {
  const _$SharedStateImpl(
      {this.status = SharedStatus.initial, this.dateFrom, this.dateTo});

  @override
  @JsonKey()
  final SharedStatus status;
  @override
  final DateTime? dateFrom;
  @override
  final DateTime? dateTo;

  @override
  String toString() {
    return 'SharedState(status: $status, dateFrom: $dateFrom, dateTo: $dateTo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SharedStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.dateFrom, dateFrom) ||
                other.dateFrom == dateFrom) &&
            (identical(other.dateTo, dateTo) || other.dateTo == dateTo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, dateFrom, dateTo);

  /// Create a copy of SharedState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SharedStateImplCopyWith<_$SharedStateImpl> get copyWith =>
      __$$SharedStateImplCopyWithImpl<_$SharedStateImpl>(this, _$identity);
}

abstract class _SharedState implements SharedState {
  const factory _SharedState(
      {final SharedStatus status,
      final DateTime? dateFrom,
      final DateTime? dateTo}) = _$SharedStateImpl;

  @override
  SharedStatus get status;
  @override
  DateTime? get dateFrom;
  @override
  DateTime? get dateTo;

  /// Create a copy of SharedState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SharedStateImplCopyWith<_$SharedStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
