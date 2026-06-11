// app_router.dart - Configuración base
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/auth_routes.dart';
import '../features/home/home_routes.dart';
import '../ui/white_page.dart';

final class AppRouter {
  AppRouter._();

  static const String initialRoute = '/';
  static const String homeRoute = '/white-home';
  
  static final GoRouter goRouter = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: initialRoute, builder: (context, state) => const WhitePage()),
      GoRoute(path: AuthRoutes.whiteRoute, builder: AuthRoutes.buildWhitePage),
      GoRoute(path: HomeRoutes.whiteRoute, builder: HomeRoutes.buildWhitePage),
      // GoRoute(
      //   path: '/details/:id',
      //   builder: (context, state) =>
      //       DetailsScreen(id: state.pathParameters['id']!),
      // ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      // Aquí puedes agregar lógica de redirección basada en la autenticación o cualquier otra condición
      // Por ejemplo:
      // final isLoggedIn = checkIfUserIsLoggedIn();
      // if (!isLoggedIn && state.subloc != '/login') {
      //   return '/login';
      // }
      return null; // No redirigir
    },
    errorPageBuilder: (context, state) => MaterialPage(
      child: Scaffold(
        body: Center(child: Text('Page not found: ${state.error}')),
      ),
    ),
  );
}
