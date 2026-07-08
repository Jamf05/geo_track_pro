import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class Failure implements Equatable {
  String get message;

  @override
  List<Object?> get props => <Object?>[message];

  @override
  bool? get stringify => true;
}

class ExceptionFailure extends Failure implements Exception {
  final Exception? error;
  final String message;
  ExceptionFailure._({required this.message, this.error});

  factory ExceptionFailure.decode(Exception? error) {
    return ExceptionFailure._(error: error, message: error.toString());
  }

  @override
  bool? get stringify => true;
}

class DioFailure extends Failure implements Exception {
  final int? statusCode;
  final DioException? error;
  final String message;
  DioFailure._({required this.message, this.statusCode, this.error});

  factory DioFailure.decode(DioException? error) {
    final Response<dynamic>? response = error?.response;
    final String statusMessage = response?.statusMessage ?? '';

    return DioFailure._(
      error: error,
      statusCode: response?.statusCode,
      message: statusMessage,
    );
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => <Object?>[error, message, statusCode];
}

class ErrorFailure extends Failure implements Error {
  final Error? error;
  final String message;
  ErrorFailure._({required this.message, this.error});

  factory ErrorFailure.decode(Error? error) {
    return ErrorFailure._(error: error, message: error.toString());
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => <Object?>[error, message];

  @override
  StackTrace? get stackTrace => error?.stackTrace;
}
