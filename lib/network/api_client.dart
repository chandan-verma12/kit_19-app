import 'package:dio/dio.dart';
import 'api_constants.dart';

class ApiClient {
  static const int TIMEOUT_TIME = 90 * 1000;

  static Dio getInstance({String? baseUrl}) {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl ?? ApiConstants.BASE_URL,
      connectTimeout: TIMEOUT_TIME,
      receiveTimeout: TIMEOUT_TIME,
    );
    return Dio(options);
  }
}
