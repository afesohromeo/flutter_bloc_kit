import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'core.dart';
// import 'theme/app_theme.dart';

class ApplicationView extends StatefulWidget {
  const ApplicationView({super.key});

  @override
  State<ApplicationView> createState() => _ApplicationViewState();
}

class _ApplicationViewState extends State<ApplicationView> {
  GoRouter? _router;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // LocalizationService.setAppLocalizations(AppLocalizations.of(context)!);


    _router = Provider.of<RouteManager>(context, listen: false).router;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MyApp',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: _router,
      theme: AppTheme.light,
      locale: const Locale('fr'),

      // darkTheme: AppTheme.dark,
      debugShowCheckedModeBanner: false,
    );
  }
}
