import 'package:commons_package/common_package.dart';

import '../dto/login_request_dto.dart';
import '../entity/user_entity.dart';

abstract class AuthRepository extends Repository {
  Future<Result<UserEntity>> login(LoginRequestDto dto);
  Future<void> logout();
}
