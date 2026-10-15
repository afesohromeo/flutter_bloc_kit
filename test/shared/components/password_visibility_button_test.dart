import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

import '../../helpers/helpers.dart';

// The icon shows the current state (developer's convention, 2026-10-06):
// open eye = password visible, crossed eye = password hidden. The tooltip
// says what a tap does.
void main() {
  late AppLocalizations l10n;

  setUpAll(() => l10n = setUpTestLocalization());

  Future<void> pumpButton(WidgetTester tester, {required bool isVisible}) =>
      tester.pumpApp(
        Scaffold(
          body: PasswordVisibilityButton(
            isVisible: isVisible,
            onPressed: () {},
          ),
        ),
      );

  testWidgets(
    'Given a hidden password then it shows the crossed eye and offers to '
    'show it',
    (tester) async {
      await pumpButton(tester, isVisible: false);

      expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
      expect(find.byIcon(Icons.visibility_outlined), findsNothing);
      expect(find.byTooltip(l10n.showPassword), findsOneWidget);
    },
  );

  testWidgets(
    'Given a visible password then it shows the open eye and offers to hide '
    'it',
    (tester) async {
      await pumpButton(tester, isVisible: true);

      expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
      expect(find.byIcon(Icons.visibility_off_outlined), findsNothing);
      expect(find.byTooltip(l10n.hidePassword), findsOneWidget);
    },
  );
}
