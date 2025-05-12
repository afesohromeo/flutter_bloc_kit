import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<_Increment>(_onIncrement);
  }

  void _onIncrement(_Increment event, Emitter<HomeState> emit) async {
    emit(state.copyWith(value: state.value + 1));
  }
}
