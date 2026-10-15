// The kit's screens on phone, tablet and desktop. See harness.dart.
// Replace these with your app's screens.
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../../test/helpers/helpers.dart';
import 'harness.dart';

void main() {
  setUpAll(() async {
    setUpTestLocalization(const Locale(shotLocale));
    await loadFonts();
  });

  // Pages use GoRouterState (drawer, back button), so they need a router.
  Widget routed(Widget page) => MaterialApp.router(
    debugShowCheckedModeBanner: false,
    theme: harnessTheme(),
    locale: const Locale(shotLocale),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    routerConfig: GoRouter(
      routes: [GoRoute(path: '/', builder: (_, _) => page)],
    ),
  );

  final sizes = {'phone': phone, 'tablet': tablet, 'desktop': desktop};

  for (final MapEntry(key: label, value: size) in sizes.entries) {
    testWidgets('home on $label', (tester) async {
      await shot(tester, 'home_$label', size, routed(const HomePage()));
    });

    testWidgets('items on $label', (tester) async {
      final bloc = MockItemsBloc();
      whenListen(
        bloc,
        Stream.value(
          ItemsState(
            itemsListStatus: GenericStatus.success,
            paginatedItems: [
              for (var i = 1; i <= 8; i++)
                anItem(id: i, name: 'Item $i', description: 'Description $i'),
            ],
            maxItems: true,
          ),
        ),
        initialState: const ItemsState(),
      );
      await shot(
        tester,
        'items_$label',
        size,
        routed(
          BlocProvider<ItemsBloc>.value(value: bloc, child: const ItemsPage()),
        ),
      );
    });
  }
}
