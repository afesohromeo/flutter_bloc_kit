part of 'shared_bloc.dart';

@freezed
class SharedEvent with _$SharedEvent {
  const factory SharedEvent.initialized() = _Initialized;
  const factory SharedEvent.datesUpdated(
      {required DateTime dateFrom, required DateTime dateTo}) = _DatesUpdated;
}
