// app_router.dart - Configuración base
import 'package:auth_package/auth_package.dart' as auth_package;
import 'package:go_router/go_router.dart';
import 'package:home_package/home_package.dart' as home_package;

import '../ui/white_page.dart';

final class AppRouter {
  AppRouter._();

  static const String initialRoute = '/';
  static const String authRoute = '/white-auth';
  static const String homeRoute = '/white-home';
  
  static final GoRouter goRouter = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: initialRoute, builder: (context, state) => const WhitePage()),
      GoRoute(path: authRoute, builder: (context, state) => const auth_package.WhitePage()),
      GoRoute(path: homeRoute, builder: (context, state) => const home_package.WhitePage()),
      // GoRoute(
      //   path: '/details/:id',
      //   builder: (context, state) =>
      //       DetailsScreen(id: state.pathParameters['id']!),
      // ),
    ],
  );
}
