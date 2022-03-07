import 'package:dio/dio.dart';
import 'package:myshopcart/core/utils/global_variables.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioService {
  final Dio dio = Dio();

  settingLog() {
    dio.interceptors.clear();
    dio.interceptors.add(PrettyDioLogger(
        error: GlobalVariables.appDebug,
        request: GlobalVariables.appDebug,
        requestBody: GlobalVariables.appDebug,
        requestHeader: GlobalVariables.appDebug,
        responseBody: GlobalVariables.appDebug,
        responseHeader: GlobalVariables.appDebug,
        compact: GlobalVariables.appDebug,
        maxWidth: 500));

    dio.options = BaseOptions(
        baseUrl: settingBaseUrl(),
        connectTimeout: GlobalVariables.connectTimeOutRequest,
        receiveTimeout: GlobalVariables.connectTimeOutRequest,
        sendTimeout: GlobalVariables.connectTimeOutRequest,
        headers: settingHeaders());

    return dio;
  }

  static settingBaseUrl() {
    if (GlobalVariables.appRelease) {
      return GlobalVariables.baseUrl;
    } else {
      return GlobalVariables.baseUrlStag;
    }
  }

  static Map<String, dynamic> settingHeaders() {
    Map<String, dynamic> headersDefault = {
      "Content-Type": 'application/json',
      "Accept-Charset": 'utf-8',
      "openapikey": GlobalVariables.apiKey
    };
    return headersDefault;
  }
}
