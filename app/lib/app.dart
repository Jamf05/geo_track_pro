import 'package:auth_package/auth_package.dart';
import 'package:commons_package/common_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:home_package/home_package.dart';

import 'config/app_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.goRouter,
      localizationsDelegates: const [
        AuthLocalizations.delegate,
        HomeLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeFoundation.lightTheme,
    );
  }
}