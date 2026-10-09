import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/helpers.dart';

void main() {
  late AppLocalizations l10n;
  late MockItemRepository repository;

  setUpAll(() => l10n = setUpTestLocalization());

  setUp(() {
    repository = MockItemRepository();
    when(
      () => repository.fetchItems(
        any(),
        keyword: any(named: 'keyword'),
        size: any(named: 'size'),
      ),
    ).thenAnswer(
      (_) async => PaginatedList(
        pagination: const Pagination(size: 20),
        content: [anItem(name: 'Pen')],
      ),
    );
  });

  Future<GoRouter> pumpApp(WidgetTester tester) async {
    final router = GoRouter(routes: RouteManager.routes);
    await tester.pumpWidget(
      RepositoryProvider<ItemRepository>.value(
        value: repository,
        child: MaterialApp.router(
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
        ),
      ),
    );
    await tester.pump();
    return router;
  }

  Future<void> settle(WidgetTester tester) async {
    // pumpAndSettle would wait forever on the skeleton's shimmer.
    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
  }

  group('Given the home page', () {
    testWidgets('when the button is tapped then the items list opens', (
      tester,
    ) async {
      await pumpApp(tester);

      await tester.tap(find.byKey(HomePage.openItemsButtonKey));
      await settle(tester);

      expect(find.byType(ItemsPage), findsOneWidget);
      expect(find.text('Pen'), findsOneWidget);
    });

    testWidgets('when the items page goes back then home is shown again', (
      tester,
    ) async {
      final router = await pumpApp(tester);
      router.goNamed(itemsRouteName);
      await settle(tester);

      await tester.tap(find.byType(CustomBackButton));
      await settle(tester);

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(ItemsPage), findsNothing);
    });

    testWidgets('when the menu opens then the drawer lists the destinations', (
      tester,
    ) async {
      await pumpApp(tester);

      await tester.tap(find.byTooltip(l10n.openMenu));
      await settle(tester);
      await tester.tap(find.widgetWithText(DrawerTile, l10n.itemsTitle));
      await settle(tester);

      expect(find.byType(ItemsPage), findsOneWidget);
    });
  });
}
