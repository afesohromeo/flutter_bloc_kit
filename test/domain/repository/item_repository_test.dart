import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  late MockItemApiProvider apiProvider;
  late ItemRepository repository;

  setUpAll(setUpTestLocalization);

  setUp(() {
    apiProvider = MockItemApiProvider();
    repository = ItemRepository(apiProvider: apiProvider);
  });

  group('Given ItemRepository.fetchItems', () {
    test('when the API returns a page then it maps the items', () async {
      when(() => apiProvider.fetchItems(0, keyword: 'pen', size: 20))
          .thenAnswer(
            (_) async => AppApiResponse.fromJson(
              pageJson([
                {'id': 1, 'name': 'Pen', 'description': 'Blue'},
                {'id': '2', 'name': 'Pencil'},
              ], size: 20),
            ),
          );

      final page = await repository.fetchItems(0, keyword: 'pen', size: 20);

      expect(page!.content, [
        anItem(id: 1, name: 'Pen', description: 'Blue'),
        anItem(id: 2, name: 'Pencil'),
      ]);
      expect(page.pagination.size, 20);
    });

    test('when the API reports a failure then it returns null', () async {
      when(() => apiProvider.fetchItems(0, keyword: null, size: null))
          .thenAnswer((_) async => AppApiResponse.fromJson({'success': false}));

      expect(await repository.fetchItems(0), isNull);
    });

    test('when the API throws then the exception reaches the caller', () async {
      when(() => apiProvider.fetchItems(0, keyword: null, size: null))
          .thenThrow(const NetworkException());

      expect(() => repository.fetchItems(0), throwsA(isA<NetworkException>()));
    });
  });

  group('Given the demo item API provider', () {
    test(
      'when asked for pages then it serves all items, then a short last page',
      () async {
        final demo = ItemRepository(
          apiProvider: DemoItemApiProvider(delay: Duration.zero),
        );

        final first = await demo.fetchItems(0, size: 20);
        final last = await demo.fetchItems(2, size: 20);

        expect(first!.content, hasLength(20));
        expect(first.content.first.name, 'Item 1');
        expect(last!.content, hasLength(DemoItemApiProvider.itemCount - 40));
      },
    );

    test('when searching then only matching items come back', () async {
      final demo = ItemRepository(
        apiProvider: DemoItemApiProvider(delay: Duration.zero),
      );

      final page = await demo.fetchItems(0, keyword: 'item 4', size: 20);

      expect(
        page!.content.map((item) => item.name),
        everyElement(contains('Item 4')),
      );
      expect(page.content, isNotEmpty);
    });
  });
}
