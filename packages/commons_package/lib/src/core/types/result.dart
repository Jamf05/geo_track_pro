import 'types.dart';

abstract class Result<T> {
  final T? data;
  final Failure? error;

  const Result({this.data, this.error});

  const factory Result.success(T data) = SuccessResult<T>;
  const factory Result.error(Failure error) = ErrorResult<T>;

  bool get isSuccess => data != null;
  bool get isError => error != null;
}

class SuccessResult<T> extends Result<T> {
  const SuccessResult(T data) : super(data: data);
}

class ErrorResult<T> extends Result<T> {
  const ErrorResult(Failure error) : super(error: error);
}