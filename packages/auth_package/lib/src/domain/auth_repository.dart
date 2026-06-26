import 'package:commons_package/common_package.dart';

import 'login_dto.dart';
import 'user_entity.dart';

abstract class AuthRepository extends Repository {
  Future<Result<UserEntity>> login(LoginRequestDto dto);
  Future<void> logout();
}
