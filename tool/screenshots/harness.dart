// Screenshot harness for design and language checks (_standards/15).
// Not part of the test suite: run with
//   flutter test --update-goldens tool/screenshots/
// and look at tool/screenshots/out/*.png. In French:
//   flutter test --update-goldens --dart-define=LOCALE=fr tool/screenshots/
// writes out/*_fr.png. Text that overflows shows up as a red/yellow stripe.
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';
import 'package:flutter_test/flutter_test.dart';

/// The language of the shots: `--dart-define=LOCALE=fr` for French.
const shotLocale = String.fromEnvironment('LOCALE', defaultValue: 'en');

const phone = Size(390, 844);
const tablet = Size(1024, 768);
const desktop = Size(1440, 900);

final _root = GlobalKey();

/// Loads real fonts, so text renders as text instead of grey boxes:
/// Roboto and the Material icons from the Flutter SDK cache.
///
/// An app with its own font loads it here too, e.g.
/// `FontLoader('Manrope')..addFont(bytes('assets/fonts/Manrope-Regular.ttf'))`.
Future<void> loadFonts() async {
  final cache =
      '${Platform.environment['FLUTTER_ROOT'] ?? ''}/bin/cache/artifacts/material_fonts';
  Future<ByteData> bytes(String path) async =>
      ByteData.view((await File(path).readAsBytes()).buffer);

  final roboto = FontLoader('Roboto');
  for (final weight in ['regular', 'medium', 'bold']) {
    roboto.addFont(bytes('$cache/roboto-$weight.ttf'));
  }
  await roboto.load();
  await (FontLoader(
    'MaterialIcons',
  )..addFont(bytes('$cache/materialicons-regular.otf'))).load();
}

/// A plain theme in the app's colours. Pass the app's real theme to [shot]
/// once its fonts are bundled (fonts downloaded at runtime, e.g. through
/// google_fonts, can't load in tests).
ThemeData harnessTheme() => ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: customColors.primary),
  fontFamily: 'Roboto',
);

/// Renders [page] at [size] and writes `out/<name>.png`
/// (`out/<name>_<locale>.png` for another language).
Future<void> shot(
  WidgetTester tester,
  String name,
  Size size,
  Widget page, {
  ThemeData? theme,
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  // flutter_test draws elevation as a black outline unless told not to.
  debugDisableShadows = false;

  await tester.pumpWidget(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme ?? harnessTheme(),
      locale: const Locale(shotLocale),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: RepaintBoundary(key: _root, child: page),
    ),
  );
  // Let animations (e.g. a shimmer) reach a visible frame.
  await tester.pump(const Duration(milliseconds: 200));
  await tester.pump(const Duration(milliseconds: 200));

  try {
    await expectLater(
      find.byKey(_root),
      matchesGoldenFile(
        shotLocale == 'en' ? 'out/$name.png' : 'out/${name}_$shotLocale.png',
      ),
    );
  } finally {
    // Checked before the tear-downs run.
    debugDisableShadows = true;
  }
}
