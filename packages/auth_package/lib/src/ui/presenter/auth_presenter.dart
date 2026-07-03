import 'package:commons_package/common_package.dart';

import '../../../auth_package.dart';

class AuthPresenter extends Presenter<AuthState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;

  AuthPresenter({
    required LoginUseCase loginUseCase,
    required LogoutUseCase logoutUseCase,
  }) : _loginUseCase = loginUseCase,
       _logoutUseCase = logoutUseCase;

  @override
  AuthState build() => const AuthInitial();

  Future<void> login({required String email, required String password}) async {
    state = const AuthLoading();

    final result = await _loginUseCase(
      LoginRequestDto(email: email, password: password),
    );

    final UserEntity? data = result.data;
    final Failure? error = result.error;

    state = data != null
        ? AuthAuthenticated(data)
        : AuthError(error?.message ?? 'Unknown error');
  }

  Future<void> logout() async {
    state = const AuthLoading();
    (await _logoutUseCase(const EmptyDto()));
    state = const AuthUnauthenticated();
  }
}
