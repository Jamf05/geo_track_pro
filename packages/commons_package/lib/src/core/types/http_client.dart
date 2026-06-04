import 'package:dio/dio.dart';

abstract class HttpClient with DioMixin implements Dio {
  HttpClient() {
    options = BaseOptions();
    httpClientAdapter = HttpClientAdapter();
  }
}