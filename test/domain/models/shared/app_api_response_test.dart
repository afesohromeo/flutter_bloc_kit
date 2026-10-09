import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('Given AppApiResponse.fromJson', () {
    test('when success is true then the response is successful', () {
      final response = AppApiResponse.fromJson({
        'success': true,
        'message': 'ok',
      });

      expect(response.success, isTrue);
      expect(response.message, 'ok');
    });

    test(
      'when there is no success flag but code 200 then it is successful',
      () {
        expect(AppApiResponse.fromJson({'code': 200}).success, isTrue);
        expect(AppApiResponse.fromJson({'code': 404}).success, isFalse);
      },
    );

    test('when data is a page then it exposes items and pagination', () {
      final response = AppApiResponse.fromJson(
        pageJson(
          [
            {'id': 1},
            {'id': 2},
          ],
          size: 20,
          totalElements: 42,
          totalPages: 3,
        ),
      );

      expect(response.data!.content, hasLength(2));
      expect(response.data!.pagination.size, 20);
      expect(response.data!.pagination.totalElement, 42);
      expect(response.data!.pagination.totalPages, 3);
    });

    test('when data is a single object then data2AsMap returns it', () {
      final response = AppApiResponse.fromJson({
        'success': true,
        'data': {'id': 7, 'name': 'Seven'},
      });

      expect(response.data2AsMap, {'id': 7, 'name': 'Seven'});
    });

    test('when data is not an object then data2AsMap is null', () {
      expect(AppApiResponse.fromJson({'data': 'text'}).data2AsMap, isNull);
      expect(
        AppApiResponse.fromJson({
          'data': [1, 2],
        }).data2AsMap,
        isNull,
      );
      expect(AppApiResponse.fromJson({}).data2AsMap, isNull);
    });

    test('when the message is missing then it is empty', () {
      expect(AppApiResponse.fromJson({}).message, '');
    });
  });
}
