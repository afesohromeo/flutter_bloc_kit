part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({@Default(0) int value}) = _HomeState;
}
