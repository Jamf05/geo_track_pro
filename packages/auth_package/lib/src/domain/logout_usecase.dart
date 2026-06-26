import 'package:commons_package/common_package.dart';

import 'auth_repository.dart';

class LogoutUseCase extends UseCase<void, EmptyDto> {
  final AuthRepository _repository;

  const LogoutUseCase(this._repository);

  @override
  Future<Result<void>> call(EmptyDto dto) async {
    await _repository.logout();
    return const Result.success(null);
  }
}
