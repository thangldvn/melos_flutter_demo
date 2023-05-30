import 'package:dio/dio.dart';
import 'package:hello/pretty_dio_logger.dart';

class RestClient {
  factory RestClient() {
    return instance;
  }

  RestClient._internal();
  static const TIMEOUT = 60000;
  static const ENABLE_LOG = true;
  static const ACCESS_TOKEN_HEADER = 'Authorization';

  // singleton
  static final RestClient instance = RestClient._internal();

  late String baseUrl;
  late Map<String, dynamic> headers;

  void init(String baseUrl, {String? accessToken}) {
    this.baseUrl = baseUrl;
    headers = {
      'Content-Type': 'application/json',
    };
    if (accessToken != null) setToken(accessToken);
  }

  void setToken(String token) {
    headers[ACCESS_TOKEN_HEADER] = 'Bearer $token';
  }

  void clearToken() {
    headers.remove(ACCESS_TOKEN_HEADER);
  }

  static Dio getDio({bool isUpload = false, String? customUrl}) {
    var dio = Dio(
        instance.getDioBaseOption(isUpload: isUpload, customUrl: customUrl));
    if (ENABLE_LOG) {
      dio.interceptors
          .add(PrettyDioLogger(requestBody: true, responseBody: false));
    }
    // dio.interceptors.add(AppInterceptors(dio));
    return dio;
  }

  BaseOptions getDioBaseOption({bool isUpload = false, String? customUrl}) {
    return BaseOptions(
      baseUrl: customUrl ?? instance.baseUrl,
      connectTimeout: TIMEOUT,
      receiveTimeout: TIMEOUT,
      headers: instance.headers,
    );
  }
}
