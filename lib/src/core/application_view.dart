import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ApplicationView extends StatefulWidget {
  const ApplicationView({super.key});

  @override
  State<ApplicationView> createState() => _ApplicationViewState();
}

class _ApplicationViewState extends State<ApplicationView> {
  late final GoRouter _router = context.read<RouteManager>().router;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => FlutterNativeSplash.remove(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Respect the user's text size, between 100% and 120%.
    final scale = MediaQuery.textScalerOf(context).scale(1).clamp(1.0, 1.2);

    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: TextScaler.linear(scale)),
      child: MaterialApp.router(
        onGenerateTitle: (context) {
          // Code without a BuildContext (BLoCs, repositories, formatters)
          // reads the current language from here.
          final l10n = AppLocalizations.of(context)!;
          LocalizationService.setAppLocalizations(l10n);
          Intl.defaultLocale = l10n.localeName;
          return l10n.appTitle;
        },
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: _router,
        theme: AppTheme.light(colors: customColors, context: context),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
