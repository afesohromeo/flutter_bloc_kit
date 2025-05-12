import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shared_event.dart';
part 'shared_state.dart';
part 'shared_bloc.freezed.dart';

class SharedBloc extends Bloc<SharedEvent, SharedState> {
  SharedBloc() : super(SharedState()) {
    on<_Initialized>(_onInitialized);

    on<_DatesUpdated>(_onDatesUpdated);
  }
  void _onInitialized(_Initialized event, Emitter<SharedState> emit) async {
    emit(state.copyWith(dateFrom: DateTime.now(), dateTo: DateTime.now()));
  }

  void _onDatesUpdated(_DatesUpdated event, Emitter<SharedState> emit) async {
    emit(state.copyWith(dateFrom: event.dateFrom, dateTo: event.dateTo));
  }
}
