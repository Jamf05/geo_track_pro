import 'package:auth_package/auth_package.dart';
import 'package:commons_package/common_package.dart';


class MockAuthRepository implements AuthRepository {
  final List<Map<String, String>> _mockUsers = [
    {
      'id': '1',
      'email': 'admin@example.com',
      'password': 'admin123',
      'name': 'Administrador',
    },
    {
      'id': '2',
      'email': 'user@example.com',
      'password': 'user123',
      'name': 'Usuario Demo',
    },
    {
      'id': '3',
      'email': 'test@example.com',
      'password': 'test123',
      'name': 'Usuario Test',
    },
  ];

  @override
  Future<Result<UserEntity>> login(LoginRequestDto dto) async {
    await Future<void>.delayed(const Duration(seconds: 2));

    if (dto.email == 'error@example.com') {
      return Result.error(
        ExceptionFailure.decode(
          Exception('Error de conexión con el servidor'),
        ),
      );
    }

    if (dto.email == 'wrong@example.com') {
      return Result.error(
        ExceptionFailure.decode(
          Exception('Credenciales inválidas'),
        ),
      );
    }

    final userMap = _mockUsers.where((u) => u['email'] == dto.email).toList();

    if (userMap.isEmpty) {
      return Result.error(
        ExceptionFailure.decode(
          Exception('Usuario no encontrado'),
        ),
      );
    }

    final user = userMap.firstOrNull;

    if(user == null) {
      return Result.error(
        ExceptionFailure.decode(
          Exception('FATAL ERROR: user is null'),
        ),
      );
    }

    if (user['password'] != dto.password) {
      return Result.error(
        ExceptionFailure.decode(
          Exception('Contraseña incorrecta'),
        ),
      );
    }

    return Result.success(
      UserEntity(
        userId: user['id']!,
        email: user['email']!,
        name: user['name']!,
      ),
    );
  }

  @override
  Future<void> logout() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
  }
}
