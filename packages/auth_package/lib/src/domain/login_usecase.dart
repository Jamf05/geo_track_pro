import 'package:commons_package/common_package.dart';

import 'auth_repository.dart';
import 'login_dto.dart';
import 'user_entity.dart';

class LoginUseCase extends UseCase<UserEntity, LoginRequestDto> {
  final AuthRepository _repository;

  const LoginUseCase(this._repository);

  @override
  Future<Result<UserEntity>> call(LoginRequestDto dto) {
    return _repository.login(dto);
  }
}
