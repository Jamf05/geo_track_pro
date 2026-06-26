import 'package:commons_package/common_package.dart';

import '../domain/auth_state.dart';
import '../domain/login_dto.dart';
import '../domain/login_usecase.dart';
import '../domain/logout_usecase.dart';

class AuthPresenter extends Presenter<AuthState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;

  AuthPresenter({
    required LoginUseCase loginUseCase,
    required LogoutUseCase logoutUseCase,
  })  : _loginUseCase = loginUseCase,
        _logoutUseCase = logoutUseCase;

  @override
  AuthState build() => const AuthInitial();

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AuthLoading();

    final result = await _loginUseCase(
      LoginRequestDto(email: email, password: password),
    );

    if (result.isSuccess) {
      state = AuthAuthenticated(result.data!);
    } else {
      state = AuthError(result.error!.message);
    }
  }

  Future<void> logout() async {
    state = const AuthLoading();
    await _logoutUseCase(const EmptyDto());
    state = const AuthUnauthenticated();
  }
}
