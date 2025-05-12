part of 'shared_bloc.dart';

enum SharedStatus {
  initial,
  loading,
  success,
  failure,
}

@freezed
class SharedState with _$SharedState {
  const factory SharedState({
    @Default(SharedStatus.initial) SharedStatus status,
    DateTime? dateFrom,
    DateTime? dateTo,
  }) = _SharedState;
}
