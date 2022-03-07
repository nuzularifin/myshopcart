import 'package:equatable/equatable.dart';

import 'exception.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class NoInternetFailure extends Failure {
  final ResponseException? exception;

  NoInternetFailure(this.exception);
}

//! For Response code  400 ++
class ResponseFailure extends Failure {
  final ResponseException? exception;

  ResponseFailure(this.exception);
}

class MetaFailure extends Failure {
  final MetaException exception;

  MetaFailure(this.exception);
}

ResponseException handlingFailure(Failure failure) {
  int? code = 400;
  String? message = 'Unknown Error';
  if (failure is ResponseFailure) {
    code = failure.exception!.errorCode;
    message = failure.exception!.message;
  }
  if (failure is MetaFailure) {
    code = failure.exception.errorCode;
    message = failure.exception.message;
  }

  if (failure is NoInternetFailure) {
    code = failure.exception!.errorCode;
    message = failure.exception!.message;
  }

  return ResponseException(errorCode: code, message: message);
}

MetaFailure handlingMetaFailure(MetaException e) {
  return MetaFailure(MetaException(
    errorCode: e.errorCode,
    message: e.message,
  ));
}

ResponseFailure handlingResponseFailure(ResponseException e) {
  return ResponseFailure(
      ResponseException(errorCode: e.errorCode, message: e.message));
}

NoInternetFailure handlingNoInternetFailure() {
  return NoInternetFailure(ResponseException(
      errorCode: 505, message: 'Bad Request - No Connecition Internet'));
}
