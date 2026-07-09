import 'package:auth_package/auth_package.dart';
import 'package:commons_package/common_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../infrastructure/auth/mock_auth_repository.dart';

AuthPresenter _createAuthPresenter() {
  final ConnectivityFactory connectivity = ConnectivityFactory.build();
  final repo = MockAuthRepository(connectivity);

  return AuthPresenter(
    loginUseCase: LoginUseCase(repo),
    logoutUseCase: LogoutUseCase(repo),
  );
}

final _authPresenterProvider = NotifierProvider<AuthPresenter, AuthState>(
  _createAuthPresenter,
);

final class AuthRoutes {
  static const String loginRoute = '/login';
  static const String whiteRoute = '/white-auth';

  static Widget buildLoginPage(BuildContext _, GoRouterState _) {
    return const ProviderScope(child: _LoginPageBridge());
  }

  static Widget buildWhitePage(BuildContext _, GoRouterState _) {
    return const WhitePage();
  }
}

class _LoginPageBridge extends ConsumerWidget {
  const _LoginPageBridge();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final presenter = ref.watch(_authPresenterProvider.notifier);

    Future<void> onLogin({
      required String email,
      required String password,
    }) async {
      await presenter.login(email: email, password: password);
      final currentState = ref.read(_authPresenterProvider);
      if (currentState is AuthError) {
        throw Exception(currentState.message);
      }
    }

    void onAuthenticated() {
      context.go('/white-home');
    }

    return LoginPage(
      onLogin: ({required String email, required String password}) =>
          onLogin(email: email, password: password),
      onAuthenticated: onAuthenticated,
    );
  }
}
