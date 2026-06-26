import 'package:auth_package/auth_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

AuthPresenter _createAuthPresenter() {
  final repo = MockAuthRepository();
  return AuthPresenter(
    loginUseCase: LoginUseCase(repo),
    logoutUseCase: LogoutUseCase(repo),
  );
}

final _authPresenterProvider =
    NotifierProvider<AuthPresenter, AuthState>(_createAuthPresenter);

final class AuthRoutes {
  static const String loginRoute = '/login';
  static const String whiteRoute = '/white-auth';

  static Widget buildLoginPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return const ProviderScope(
      child: _LoginPageBridge(),
    );
  }

  static Widget buildWhitePage(
    BuildContext context,
    GoRouterState state,
  ) {
    return const WhitePage();
  }
}

class _LoginPageBridge extends ConsumerWidget {
  const _LoginPageBridge();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final presenter = ref.watch(_authPresenterProvider.notifier);

    return LoginPage(
      onLogin: ({required String email, required String password}) async {
        await presenter.login(email: email, password: password);
        final currentState = ref.read(_authPresenterProvider);
        if (currentState is AuthError) {
          throw Exception(currentState.message);
        }
      },
      onAuthenticated: () {
        context.go('/white-home');
      },
    );
  }
}