import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/helpers.dart';

void main() {
  late AppLocalizations l10n;
  late MockItemRepository repository;

  final firstPage = PaginatedList<Item>(
    pagination: const Pagination(size: 2),
    content: [anItem(id: 1), anItem(id: 2)],
  );

  setUpAll(() => l10n = setUpTestLocalization());

  setUp(() => repository = MockItemRepository());

  void whenFetch(Future<PaginatedList<Item>?> Function() answer) {
    when(
      () => repository.fetchItems(
        any(),
        keyword: any(named: 'keyword'),
        size: any(named: 'size'),
      ),
    ).thenAnswer((_) => answer());
  }

  group('Given the items bloc', () {
    blocTest<ItemsBloc, ItemsState>(
      'when the first page loads then it emits loading then the page',
      setUp: () => whenFetch(() async => firstPage),
      build: () => ItemsBloc(repository: repository),
      act: (bloc) => bloc.add(const ItemsEvent.fetchItems()),
      expect: () => [
        const ItemsState(itemsListStatus: GenericStatus.loading),
        ItemsState(
          itemsListStatus: GenericStatus.success,
          items: firstPage.content,
          paginatedItems: firstPage.content,
          maxItems: false,
        ),
      ],
    );

    blocTest<ItemsBloc, ItemsState>(
      'when a page is shorter than the page size then it is the last one',
      setUp: () => whenFetch(
        () async => PaginatedList(
          pagination: const Pagination(size: 20),
          content: [anItem(id: 3)],
        ),
      ),
      build: () => ItemsBloc(repository: repository),
      seed: () => ItemsState(items: firstPage.content),
      act: (bloc) => bloc.add(const ItemsEvent.fetchItems(pageKey: 1)),
      skip: 1,
      expect: () => [
        ItemsState(
          itemsListStatus: GenericStatus.success,
          items: [...firstPage.content, anItem(id: 3)],
          paginatedItems: [anItem(id: 3)],
          maxItems: true,
          itemsPageKey: 1,
        ),
      ],
    );

    blocTest<ItemsBloc, ItemsState>(
      'when a search term is given then it filters on the server',
      setUp: () => whenFetch(() async => firstPage),
      build: () => ItemsBloc(repository: repository),
      act: (bloc) => bloc.add(const ItemsEvent.fetchItems(searchTerm: 'pen')),
      expect: () => [
        const ItemsState(itemsListStatus: GenericStatus.filtering),
        isA<ItemsState>(),
      ],
      verify: (_) => verify(
        () => repository.fetchItems(
          0,
          keyword: 'pen',
          size: any(named: 'size'),
        ),
      ).called(1),
    );

    blocTest<ItemsBloc, ItemsState>(
      'when the repository returns nothing then it emits the list error',
      setUp: () => whenFetch(() async => null),
      build: () => ItemsBloc(repository: repository),
      act: (bloc) => bloc.add(const ItemsEvent.fetchItems()),
      skip: 1,
      expect: () => [
        ItemsState(
          itemsListStatus: GenericStatus.failure,
          itemsListError: l10n.errorLoadingItems,
        ),
      ],
    );

    blocTest<ItemsBloc, ItemsState>(
      'when the server rejects the request then it shows the server message',
      setUp: () =>
          whenFetch(() async => throw const HttpException400('Bad filter')),
      build: () => ItemsBloc(repository: repository),
      act: (bloc) => bloc.add(const ItemsEvent.fetchItems()),
      skip: 1,
      expect: () => [
        const ItemsState(
          itemsListStatus: GenericStatus.failure,
          itemsListError: 'Bad filter',
        ),
      ],
    );

    blocTest<ItemsBloc, ItemsState>(
      'when the session has ended then it says so',
      setUp: () => whenFetch(() async => throw const HttpException401()),
      build: () => ItemsBloc(repository: repository),
      act: (bloc) => bloc.add(const ItemsEvent.fetchItems()),
      skip: 1,
      expect: () => [
        ItemsState(
          itemsListStatus: GenericStatus.failure,
          itemsListError: l10n.errorUnauthorized,
        ),
      ],
    );

    blocTest<ItemsBloc, ItemsState>(
      'when the network fails then it shows the network error',
      setUp: () => whenFetch(() async => throw const NetworkException()),
      build: () => ItemsBloc(repository: repository),
      act: (bloc) => bloc.add(const ItemsEvent.fetchItems()),
      skip: 1,
      expect: () => [
        ItemsState(
          itemsListStatus: GenericStatus.failure,
          itemsListError: l10n.networkError,
        ),
      ],
    );

    blocTest<ItemsBloc, ItemsState>(
      'when refreshed then it clears the list and asks the page to reload',
      build: () => ItemsBloc(repository: repository),
      seed: () => ItemsState(
        itemsListStatus: GenericStatus.success,
        items: firstPage.content,
        itemsPageKey: 3,
        maxItems: true,
      ),
      act: (bloc) => bloc.add(const ItemsEvent.refreshItems()),
      expect: () => [const ItemsState(itemsRefreshController: true)],
    );
  });
}
