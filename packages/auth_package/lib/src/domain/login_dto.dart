import 'package:commons_package/common_package.dart';

class LoginRequestDto extends Dto {
  final String email;
  final String password;

  const LoginRequestDto({
    required this.email,
    required this.password,
  });
}

class LoginResponseDto extends Dto {
  final String id;
  final String email;
  final String name;

  const LoginResponseDto({
    required this.id,
    required this.email,
    required this.name,
  });
}
