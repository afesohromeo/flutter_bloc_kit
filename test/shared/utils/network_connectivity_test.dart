import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockConnectivity extends Mock implements Connectivity {}

void main() {
  late _MockConnectivity connectivity;
  late int probeCalls;
  late bool probeResult;

  NetworkConnectivity build() => NetworkConnectivity(
    connectivity: connectivity,
    probe: () async {
      probeCalls++;
      return probeResult;
    },
  );

  setUp(() {
    connectivity = _MockConnectivity();
    probeCalls = 0;
    probeResult = true;
  });

  group('Given NetworkConnectivity.isOnline', () {
    test(
      'when no interface is up then it is offline without probing',
      () async {
        when(() => connectivity.checkConnectivity())
            .thenAnswer((_) async => [ConnectivityResult.none]);

        expect(await build().isOnline(), isFalse);
        expect(probeCalls, 0);
      },
    );

    test(
      'when an interface is up and the probe succeeds then it is online',
      () async {
        when(() => connectivity.checkConnectivity())
            .thenAnswer((_) async => [ConnectivityResult.wifi]);

        expect(await build().isOnline(), isTrue);
        expect(probeCalls, 1);
      },
    );

    test(
      'when an interface is up but the probe fails then it is offline',
      () async {
        probeResult = false;
        when(() => connectivity.checkConnectivity())
            .thenAnswer((_) async => [ConnectivityResult.mobile]);

        expect(await build().isOnline(), isFalse);
      },
    );
  });

  group('Given NetworkConnectivity.onConnectivityChanged', () {
    test('when the status repeats then it is reported once', () async {
      when(() => connectivity.onConnectivityChanged).thenAnswer(
        (_) => Stream.fromIterable([
          [ConnectivityResult.wifi],
          [ConnectivityResult.mobile],
          [ConnectivityResult.none],
        ]),
      );

      expect(await build().onConnectivityChanged.toList(), [true, false]);
    });
  });
}
