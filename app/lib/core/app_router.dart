// app_router.dart - Configuración base
import 'package:go_router/go_router.dart';

final class AppRouter {
  AppRouter._();
  
  static final GoRouter goRouter = GoRouter(
    initialLocation: '/login',
    routes: [
      // GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      // GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
      // GoRoute(
      //   path: '/details/:id',
      //   builder: (context, state) =>
      //       DetailsScreen(id: state.pathParameters['id']!),
      // ),
    ],
  );
}
