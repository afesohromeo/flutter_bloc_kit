import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Whether the text field inside the widget found by [fieldKey] hides its text.
bool isObscured(WidgetTester tester, Key fieldKey) {
  final textField = tester.widget<TextField>(
    find.descendant(of: find.byKey(fieldKey), matching: find.byType(TextField)),
  );
  return textField.obscureText;
}

/// The text currently in the text field inside the widget found by [fieldKey].
String fieldText(WidgetTester tester, Key fieldKey) {
  final textField = tester.widget<TextField>(
    find.descendant(of: find.byKey(fieldKey), matching: find.byType(TextField)),
  );
  return textField.controller?.text ?? '';
}

/// The autofill hints of the text field inside the widget found by [fieldKey].
Iterable<String> autofillHintsOf(WidgetTester tester, Key fieldKey) {
  final textField = tester.widget<TextField>(
    find.descendant(of: find.byKey(fieldKey), matching: find.byType(TextField)),
  );
  return textField.autofillHints ?? const [];
}

/// Whether the text field inside the widget found by [fieldKey] is read-only.
bool isReadOnly(WidgetTester tester, Key fieldKey) {
  final textField = tester.widget<TextField>(
    find.descendant(of: find.byKey(fieldKey), matching: find.byType(TextField)),
  );
  return textField.readOnly;
}

/// What the page told the password manager each time it closed an autofill
/// context: `true` offers to save the typed credentials, `false` drops them.
List<bool> autofillContextsFinished(WidgetTester tester) => tester
    .testTextInput
    .log
    .where((call) => call.method == 'TextInput.finishAutofillContext')
    .map((call) => call.arguments as bool)
    .toList();
