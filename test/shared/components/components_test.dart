import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  late AppLocalizations l10n;

  setUpAll(() => l10n = setUpTestLocalization());

  group('Given ScaffoldWrapper', () {
    testWidgets('when showBottomNav is on then the bottom nav is shown', (
      tester,
    ) async {
      await tester.pumpApp(
        const ScaffoldWrapper(
          body: Text('body'),
          showBottomNav: true,
          bottomNav: Text('nav'),
          showFloatingButton: false,
          hasAppbar: false,
          showDrawer: false,
        ),
      );

      expect(find.text('nav'), findsOneWidget);
    });

    testWidgets('when showBottomNav is off then the bottom nav is hidden', (
      tester,
    ) async {
      await tester.pumpApp(
        const ScaffoldWrapper(
          body: Text('body'),
          showBottomNav: false,
          bottomNav: Text('nav'),
          showFloatingButton: false,
          hasAppbar: false,
          showDrawer: false,
        ),
      );

      expect(find.text('nav'), findsNothing);
    });
  });

  group('Given ErrorStateWidget', () {
    testWidgets('when no button text is given then it offers "Try again"', (
      tester,
    ) async {
      var taps = 0;
      await tester.pumpApp(
        Scaffold(
          body: ErrorStateWidget(
            errorMessage: 'Broken',
            onPressed: () => taps++,
          ),
        ),
      );

      expect(find.text('Broken'), findsOneWidget);
      await tester.tap(find.text(l10n.retry));
      expect(taps, 1);
    });
  });

  group('Given ShimmerSkeleton', () {
    testWidgets('when animations are reduced then it stays still', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MediaQuery(
          data: MediaQueryData(disableAnimations: true),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: ShimmerSkeleton(child: SkeletonBox(height: 20)),
          ),
        ),
      );

      expect(tester.hasRunningAnimations, isFalse);
    });

    testWidgets('when animations are allowed then it animates', (tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: ShimmerSkeleton(child: SkeletonBox(height: 20)),
        ),
      );

      expect(tester.hasRunningAnimations, isTrue);
    });
  });

  group('Given SearchInputField', () {
    testWidgets(
      'when onSuffixPressed is set then the search icon is a button',
      (tester) async {
        var taps = 0;
        await tester.pumpApp(
          Scaffold(
            body: SearchInputField(
              onChanged: (_) {},
              labelText: l10n.search,
              onSuffixPressed: () => taps++,
            ),
          ),
        );

        await tester.tap(find.byIcon(Icons.search_rounded));
        expect(taps, 1);
      },
    );
  });

  group('Given InputField', () {
    testWidgets('when autofill hints are given then the text field gets them', (
      tester,
    ) async {
      await tester.pumpApp(
        const Scaffold(
          body: InputField(
            validator: null,
            autofillHints: [AutofillHints.email],
          ),
        ),
      );

      final field = tester.widget<TextField>(find.byType(TextField));
      expect(field.autofillHints, [AutofillHints.email]);
    });
  });

  group('Given AppBottomNavBar', () {
    testWidgets('when a tab is tapped then its index is reported', (
      tester,
    ) async {
      int? tapped;
      await tester.pumpApp(
        Scaffold(
          bottomNavigationBar: AppBottomNavBar(
            items: const [
              NavItem(
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: 'Home',
              ),
              NavItem(
                icon: Icons.list_outlined,
                activeIcon: Icons.list,
                label: 'List',
              ),
            ],
            currentIndex: 0,
            onTap: (index) => tapped = index,
          ),
        ),
      );

      expect(find.byIcon(Icons.home), findsOneWidget); // active tab
      await tester.tap(find.text('List'));
      expect(tapped, 1);
    });
  });

  group('Given MeasureSize', () {
    testWidgets('when its child is laid out then it reports the size', (
      tester,
    ) async {
      Size? reported;
      await tester.pumpWidget(
        Center(
          child: MeasureSize(
            onChange: (size) => reported = size,
            child: const SizedBox(width: 40, height: 30),
          ),
        ),
      );
      await tester.pump();

      expect(reported, const Size(40, 30));
    });
  });
}
