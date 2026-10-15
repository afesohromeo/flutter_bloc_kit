import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

// Ported from Plotwatch (design pass, Oct 2026).
void main() {
  setUpAll(setUpTestLocalization);

  group('Given a breadcrumb', () {
    Future<List<String>> pumpCrumb(WidgetTester tester, double width) async {
      final tapped = <String>[];
      BreadcrumbItem item(String label) =>
          BreadcrumbItem(label, onTap: () => tapped.add(label));
      await tester.pumpApp(
        Scaffold(
          body: Center(
            child: SizedBox(
              width: width,
              child: Breadcrumb(
                items: [
                  item('Projects'),
                  item('Maison Douala'),
                  item('Stages'),
                  item('Walls'),
                  const BreadcrumbItem('Photo'),
                ],
              ),
            ),
          ),
        ),
      );
      return tapped;
    }

    testWidgets('when it fits then every part shows and each but the last '
        'opens its page', (tester) async {
      final tapped = await pumpCrumb(tester, 800);

      await tester.tap(find.text('Maison Douala'));
      await tester.tap(find.text('Stages'));
      await tester.tap(find.text('Photo'));

      expect(tapped, ['Maison Douala', 'Stages']);
      expect(find.text('…'), findsNothing);
    });

    testWidgets('when it is too long then the middle folds, keeping the first '
        'and the last two', (tester) async {
      await pumpCrumb(tester, 240);

      expect(find.text('Projects'), findsOneWidget);
      expect(find.text('…'), findsOneWidget);
      expect(find.text('Maison Douala'), findsNothing);
      expect(find.text('Walls'), findsOneWidget);
      expect(find.text('Photo'), findsOneWidget);
    });
  });

  group('Given segmented panels', () {
    Widget panels(List<Panel> list) => Scaffold(
      body: SingleChildScrollView(child: SegmentedPanels(panels: list)),
    );

    testWidgets('then the first panel shows and a segment switches', (
      tester,
    ) async {
      await tester.pumpApp(
        panels(const [
          Panel(label: 'Activity', child: Text('activity body')),
          Panel(label: 'Site', child: Text('site body')),
        ]),
      );

      expect(find.text('activity body'), findsOneWidget);
      expect(find.text('site body'), findsNothing);

      await tester.tap(find.byKey(SegmentedPanels.segmentKey(1)));
      await tester.pumpAndSettle();

      expect(find.text('activity body'), findsNothing);
      expect(find.text('site body'), findsOneWidget);
    });

    testWidgets('then a single panel shows without a switch', (tester) async {
      await tester.pumpApp(
        panels(const [Panel(label: 'Checklist', child: Text('items'))]),
      );

      expect(find.text('items'), findsOneWidget);
      expect(find.text('Checklist'), findsNothing);
      expect(find.byKey(SegmentedPanels.segmentKey(0)), findsNothing);
    });

    testWidgets('then a narrow content layout puts labelled sides behind it', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(400, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpApp(
        const Scaffold(
          body: ContentLayout(
            main: [Text('main')],
            sideLabels: ['A', 'B'],
            side: [Text('side a'), Text('side b')],
          ),
        ),
      );

      expect(find.text('main'), findsOneWidget);
      expect(find.text('side a'), findsOneWidget);
      expect(find.text('side b'), findsNothing);
      expect(find.byType(SegmentedPanels), findsOneWidget);
    });

    testWidgets('then a wide content layout keeps the side column', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1200, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpApp(
        const Scaffold(
          body: ContentLayout(
            main: [Text('main')],
            sideLabels: ['A', 'B'],
            side: [Text('side a'), Text('side b')],
          ),
        ),
      );

      expect(find.text('side a'), findsOneWidget);
      expect(find.text('side b'), findsOneWidget);
      expect(find.byType(SegmentedPanels), findsNothing);
    });
  });

  // One action shows as an icon; two or more go behind a menu.
  group('Given app bar actions', () {
    AppBarMenuItem item(String label) => AppBarMenuItem(
      key: Key('item.$label'),
      label: label,
      icon: Icons.edit_outlined,
      onTap: () {},
    );

    testWidgets('then one action shows as an icon', (tester) async {
      await tester.pumpApp(
        Scaffold(
          appBar: AppBar(
            actions: [
              AppBarMenu(items: [item('Edit')]),
            ],
          ),
        ),
      );

      expect(find.byKey(AppBarMenu.buttonKey), findsNothing);
      expect(find.byKey(const Key('item.Edit')), findsOneWidget);
    });

    testWidgets('then two actions go behind a menu', (tester) async {
      await tester.pumpApp(
        Scaffold(
          appBar: AppBar(
            actions: [
              AppBarMenu(items: [item('A'), item('B')]),
            ],
          ),
        ),
      );

      expect(find.byKey(AppBarMenu.buttonKey), findsOneWidget);
      expect(find.byKey(const Key('item.A')), findsNothing);
      await tester.tap(find.byKey(AppBarMenu.buttonKey));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('item.B')), findsOneWidget);
    });
  });

  // Filter pills, a picker pill and the sort button.
  group('Given filter components', () {
    const choices = [
      FilterChoice<int?>(null, 'All'),
      FilterChoice<int?>(1, 'One'),
      FilterChoice<int?>(2, 'Two'),
    ];

    testWidgets('then a pill reports its choice, and the chosen one is not '
        'reported again', (tester) async {
      final chosen = <int?>[];
      await tester.pumpApp(
        Scaffold(
          body: FilterChips<int?>(
            keyPrefix: 'f',
            choices: choices,
            selected: null,
            onSelected: chosen.add,
          ),
        ),
      );

      await tester.tap(find.byKey(FilterChips.chipKey('f', 2)));
      await tester.tap(find.byKey(FilterChips.chipKey('f', 0)));

      expect(chosen, [2]);
      expect(
        tester
            .widget<FilterPill>(find.byKey(FilterChips.chipKey('f', 0)))
            .selected,
        isTrue,
      );
    });

    testWidgets('then a picker shows its choice and opens the others', (
      tester,
    ) async {
      final chosen = <int?>[];
      await tester.pumpApp(
        Scaffold(
          body: PickerPill<int?>(
            keyPrefix: 'p',
            choices: choices,
            selected: 1,
            onSelected: chosen.add,
          ),
        ),
      );
      expect(find.text('One'), findsOneWidget);

      await tester.tap(find.byKey(const Key('p')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(PickerPill.optionKey('p', 2)));
      await tester.pumpAndSettle();

      expect(chosen, [2]);
    });

    testWidgets('then the sort button checks the current order', (
      tester,
    ) async {
      final chosen = <int?>[];
      await tester.pumpApp(
        Scaffold(
          body: SortButton<int?>(
            choices: choices,
            selected: 2,
            onSelected: chosen.add,
          ),
        ),
      );

      await tester.tap(find.byKey(SortButton.buttonKey));
      await tester.pumpAndSettle();
      final item = tester.widget<CheckedPopupMenuItem<int>>(
        find.byKey(SortButton.optionKey(2)),
      );
      expect(item.checked, isTrue);
      await tester.tap(find.byKey(SortButton.optionKey(1)));
      await tester.pumpAndSettle();

      expect(chosen, [1]);
    });
  });
}
