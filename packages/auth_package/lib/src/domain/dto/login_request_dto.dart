import 'package:commons_package/common_package.dart';

class LoginRequestDto extends Dto {
  final String email;
  final String password;

  const LoginRequestDto({
    required this.email,
    required this.password,
  });
}