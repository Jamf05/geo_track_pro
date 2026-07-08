import 'package:commons_package/common_package.dart';

class UserEntity extends Entity {
  final String userId;
  final String email;
  final String name;

  const UserEntity({
    required this.userId,
    required this.email,
    required this.name,
  });

  @override
  List<Object?> get props => [userId, email, name];
}
