import 'package:commons_package/common_package.dart';

class LoginResponseDto extends Dto {
  final String identifier;
  final String email;
  final String name;

  const LoginResponseDto({
    required this.identifier,
    required this.email,
    required this.name,
  });
}
