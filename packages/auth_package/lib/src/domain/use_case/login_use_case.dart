import 'package:commons_package/common_package.dart';

import '../dto/login_request_dto.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

class LoginUseCase extends UseCase<UserEntity, LoginRequestDto> {
  final AuthRepository _repository;

  const LoginUseCase(this._repository);

  @override
  Future<Result<UserEntity>> call(LoginRequestDto dto) {
    return _repository.login(dto);
  }
}
