
import 'dto.dart';
import 'result.dart';

abstract class UseCase<T, D extends Dto> {
  const UseCase();
  
  Future<Result<T>> call(D dto);
}