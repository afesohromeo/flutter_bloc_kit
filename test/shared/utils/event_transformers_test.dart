import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';
import 'package:flutter_test/flutter_test.dart';

class _QueryBloc extends Bloc<String, List<String>> {
  _QueryBloc() : super(const []) {
    on<String>(
      (query, emit) => emit([...state, query]),
      transformer: debounceSequential(const Duration(milliseconds: 300)),
    );
  }
}

void main() {
  group('Given a BLoC using debounceSequential', () {
    blocTest<_QueryBloc, List<String>>(
      'when events arrive faster than the delay then only the last is handled',
      build: _QueryBloc.new,
      act: (bloc) async {
        bloc
          ..add('f')
          ..add('fl')
          ..add('flu');
        await Future<void>.delayed(const Duration(milliseconds: 400));
      },
      expect: () => [
        ['flu'],
      ],
    );

    blocTest<_QueryBloc, List<String>>(
      'when events are spaced beyond the delay then each one is handled',
      build: _QueryBloc.new,
      act: (bloc) async {
        bloc.add('a');
        await Future<void>.delayed(const Duration(milliseconds: 400));
        bloc.add('b');
        await Future<void>.delayed(const Duration(milliseconds: 400));
      },
      expect: () => [
        ['a'],
        ['a', 'b'],
      ],
    );
  });
}
