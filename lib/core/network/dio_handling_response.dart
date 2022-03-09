import 'package:dio/dio.dart';
import 'package:myshopcart/core/error/exception.dart';

class DioHandlingResponse {
  final DioError dioError;

  DioHandlingResponse(this.dioError);

  setThrow() {
    if (dioError.type == DioErrorType.connectTimeout) {
      return ResponseException(errorCode: 500, message: dioError.type.name);
    } else if (dioError.type == DioErrorType.other) {
      print(
          'Error Type - OTHER - Get Response Code -> ${dioError.response!.statusCode}');
      if (dioError.response!.statusCode == 401) {
        return UnauthorizeException();
      } else {
        return ResponseException(
            errorCode: dioError.response!.statusCode,
            message: dioError.response!.statusMessage);
      }
    } else if (dioError.type == DioErrorType.response) {
      if (dioError.response!.statusCode == 402) {
        print(
            'Error Type - ${dioError.type} - Get Response Code -> ${dioError.response!.statusCode}');
      } else if (dioError.response!.statusCode == 401) {
        print(
            'Error Type - ${dioError.type} - Get Response Code -> ${dioError.response!.statusCode}');
      } else {
        print(
            'Error Type - ${dioError.type} - Get Response Code -> ${dioError.response!.statusCode}');
        return ResponseException(
            errorCode: dioError.response!.statusCode,
            message: dioError.response!.statusMessage);
      }
    }
  }
}
