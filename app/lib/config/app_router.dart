// app_router.dart - Configuración base
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/auth_routes.dart';
import '../features/home/home_routes.dart';
import '../ui/white_page.dart';

final class AppRouter {
  AppRouter._();

  static const String initialRoute = '/';
  static const String loginRoute = AuthRoutes.loginRoute;
  static const String homeRoute = '/white-home';

  static final GoRouter goRouter = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(path: initialRoute, builder: (context, state) => const WhitePage()),
      GoRoute(path: loginRoute, builder: AuthRoutes.buildLoginPage),
      GoRoute(path: AuthRoutes.whiteRoute, builder: AuthRoutes.buildWhitePage),
      GoRoute(path: HomeRoutes.whiteRoute, builder: HomeRoutes.buildWhitePage),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      return null;
    },
    errorPageBuilder: (context, state) => MaterialPage(
      child: Scaffold(
        body: Center(child: Text('Page not found: ${state.error}')),
      ),
    ),
  );
}
