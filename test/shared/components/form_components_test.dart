import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  late AppLocalizations l10n;

  setUpAll(() => l10n = setUpTestLocalization());

  group('Given SubmitButton', () {
    testWidgets('when it is tapped then it reports the tap', (tester) async {
      var taps = 0;
      await tester.pumpApp(
        Scaffold(
          body: SubmitButton(label: 'Save', onPressed: () => taps++),
        ),
      );

      await tester.tap(find.text('Save'));

      expect(taps, 1);
    });

    testWidgets('when it is loading then it shows a spinner and ignores taps', (
      tester,
    ) async {
      var taps = 0;
      await tester.pumpApp(
        Scaffold(
          body: SubmitButton(
            label: 'Save',
            isLoading: true,
            onPressed: () => taps++,
          ),
        ),
      );

      expect(find.text('Save'), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.tap(find.byType(SubmitButton));
      expect(taps, 0);
    });
  });

  group('Given showConfirmDialog', () {
    Future<bool?> openAndChoose(WidgetTester tester, String choice) async {
      bool? result;
      await tester.pumpApp(
        Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () async => result = await showConfirmDialog(
                context,
                title: 'Remove member?',
                message: 'They lose access.',
                confirmLabel: 'Remove',
              ),
              child: const Text('open'),
            ),
          ),
        ),
      );
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
      expect(find.text('Remove member?'), findsOneWidget);
      await tester.tap(find.text(choice));
      await tester.pumpAndSettle();
      return result;
    }

    testWidgets('when the user confirms then it returns true', (tester) async {
      expect(await openAndChoose(tester, 'Remove'), isTrue);
    });

    testWidgets('when the user cancels then it returns false', (tester) async {
      expect(await openAndChoose(tester, l10n.cancel), isFalse);
    });

    testWidgets('when a cancel label is given then the dismiss button uses it '
        'and returns false', (tester) async {
      bool? result;
      await tester.pumpApp(
        Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () async => result = await showConfirmDialog(
                context,
                title: 'Cancel order #12?',
                message: 'This cannot be undone.',
                confirmLabel: 'Cancel order',
                cancelLabel: 'Keep order',
              ),
              child: const Text('open'),
            ),
          ),
        ),
      );
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();

      expect(find.text(l10n.cancel), findsNothing);
      await tester.tap(find.text('Keep order'));
      await tester.pumpAndSettle();
      expect(result, isFalse);
    });
  });

  group('Given OneLineText', () {
    testWidgets('when the text is wider than its space then it stays on one '
        'line and shrinks', (tester) async {
      await tester.pumpApp(
        const Scaffold(
          body: SizedBox(width: 80, child: OneLineText('20,650,000 FCFA')),
        ),
      );

      final text = tester.widget<Text>(find.text('20,650,000 FCFA'));
      expect(text.maxLines, 1);
      expect(
        tester.getSize(find.byType(OneLineText)).width,
        lessThanOrEqualTo(80),
      );
    });
  });

  group('Given AuthFormLayout', () {
    testWidgets('when the screen is wide then the form is at most 420 px', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1400, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpApp(
        const Scaffold(
          body: AuthFormLayout(
            title: 'Sign in',
            subtitle: 'Welcome back',
            children: [SizedBox(key: Key('field'), height: 40, width: 2000)],
          ),
        ),
      );

      expect(find.text('Sign in'), findsOneWidget);
      expect(find.text('Welcome back'), findsOneWidget);
      expect(
        tester.getSize(find.byKey(const Key('field'))).width,
        lessThanOrEqualTo(AuthFormLayout.maxWidth),
      );
    });
  });

  group('Given MoneyField', () {
    final formKey = GlobalKey<FormState>();
    const fieldKey = Key('test.money');

    Future<void> pump(WidgetTester tester) => tester.pumpApp(
      // A text field needs a Material ancestor; pages get it from their
      // scaffold.
      Material(
        child: Form(
          key: formKey,
          child: MoneyField(
            key: fieldKey,
            controller: TextEditingController(),
            currencyCode: 'XAF',
            labelText: 'Amount',
          ),
        ),
      ),
    );

    testWidgets('then it shows the currency', (tester) async {
      await pump(tester);

      expect(find.text('FCFA'), findsOneWidget);
    });

    testWidgets('when an amount is typed then the form passes', (tester) async {
      await pump(tester);

      await tester.enterText(find.byKey(fieldKey), '1,500,000');

      expect(formKey.currentState!.validate(), isTrue);
    });

    testWidgets('when it is empty then the form passes (no amount yet)', (
      tester,
    ) async {
      await pump(tester);

      expect(formKey.currentState!.validate(), isTrue);
    });

    testWidgets('when the text is not an amount then it says so', (
      tester,
    ) async {
      await pump(tester);

      await tester.enterText(find.byKey(fieldKey), '12.5');
      final valid = formKey.currentState!.validate();
      await tester.pump();

      expect(valid, isFalse);
      expect(find.text(l10n.validateAmountInvalid), findsOneWidget);
    });
  });
}
