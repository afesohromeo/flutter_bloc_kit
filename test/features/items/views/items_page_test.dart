import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/helpers.dart';

void main() {
  late AppLocalizations l10n;
  late MockItemsBloc bloc;

  setUpAll(() => l10n = setUpTestLocalization());

  setUp(() => bloc = MockItemsBloc());

  Future<void> pumpPage(WidgetTester tester, List<ItemsState> states) async {
    whenListen(
      bloc,
      Stream.fromIterable(states),
      initialState: const ItemsState(),
    );
    await tester.pumpApp(
      BlocProvider<ItemsBloc>.value(value: bloc, child: const ItemsPage()),
    );
    await tester.pump(); // deliver the states
    await tester.pump(const Duration(milliseconds: 50));
  }

  group('Given the items page', () {
    testWidgets('when it opens then it asks for the first page', (
      tester,
    ) async {
      await pumpPage(tester, const []);

      verify(() => bloc.add(const ItemsEvent.fetchItems())).called(1);
    });

    testWidgets('when a page arrives then its items are listed', (
      tester,
    ) async {
      await pumpPage(tester, [
        ItemsState(
          itemsListStatus: GenericStatus.success,
          paginatedItems: [
            anItem(id: 1, name: 'Pen'),
            anItem(id: 2, name: 'Ink'),
          ],
          maxItems: true,
        ),
      ]);

      expect(find.text('Pen'), findsOneWidget);
      expect(find.text('Ink'), findsOneWidget);
    });

    testWidgets('when the list is empty then it shows the empty state', (
      tester,
    ) async {
      await pumpPage(tester, const [
        ItemsState(itemsListStatus: GenericStatus.success, maxItems: true),
      ]);

      expect(find.text(l10n.itemsEmptyState), findsOneWidget);
    });

    testWidgets('when loading fails then it shows the error with a retry', (
      tester,
    ) async {
      await pumpPage(tester, [
        ItemsState(
          itemsListStatus: GenericStatus.failure,
          itemsListError: l10n.networkError,
        ),
      ]);

      expect(find.text(l10n.networkError), findsOneWidget);

      await tester.tap(find.text(l10n.retry));
      verify(() => bloc.add(const ItemsEvent.refreshItems())).called(1);
    });

    testWidgets('when the user types a search then the list refreshes once', (
      tester,
    ) async {
      await pumpPage(tester, const []);

      await tester.enterText(
        find.descendant(
          of: find.byKey(ItemsPage.searchFieldKey),
          matching: find.byType(TextField),
        ),
        'pen',
      );
      await tester.pump(const Duration(milliseconds: 300));
      verifyNever(() => bloc.add(const ItemsEvent.refreshItems()));

      await tester.pump(const Duration(milliseconds: 300));
      verify(() => bloc.add(const ItemsEvent.refreshItems())).called(1);
    });

    testWidgets(
      'when the app has no backend then it says the data is demo data',
      (tester) async {
        await pumpPage(tester, const []);

        expect(find.byKey(ItemsPage.demoNoticeKey), findsOneWidget);
        expect(find.text(l10n.itemsDemoNotice), findsOneWidget);
      },
    );
  });
}
