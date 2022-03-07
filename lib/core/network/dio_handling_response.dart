import 'package:dio/dio.dart';
import 'package:myshopcart/core/error/exception.dart';

class DioHandlingResponse {
  final DioError dioError;

  DioHandlingResponse(this.dioError);

  setThrow() {
    if (dioError.type == DioErrorType.connectTimeout) {
      // throw ServerException();
      int code = dioError.response!.statusCode!;
      String message = dioError.response!.statusMessage!;
      return ResponseException(errorCode: code, message: message);
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
        // ResponseCore responseCore =
        //     ResponseCore.fromJson(dioError.response!.data);
        // return MetaException(
        //     errorCode: responseCore.meta.code,
        //     message: responseCore.meta.errorMessage);
      } else if (dioError.response!.statusCode == 401) {
        print(
            'Error Type - ${dioError.type} - Get Response Code -> ${dioError.response!.statusCode}');
        // ResponseCore responseCore =
        //     ResponseCore.fromJson(dioError.response!.data);
        // return MetaException(
        //     errorCode: responseCore.meta.code,
        //     message: responseCore.meta.errorMessage);
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
