import 'dart:convert';

import 'package:common/logger/flutter_logger.dart';
import 'package:dependencies/dio.dart' as dio;
// ' as dio;
import 'package:hello/api_response.dart';
import 'package:hello/exceptions/data_exception.dart';
import 'package:hello/rest_client.dart';

enum JsonType {
  FULL_RESPONSE,
  JSON_RESPONSE,
  BODY_BYTES,
  STRING_RESPONSE,
  CUSTOM_RESPONSE
}

abstract class IBaseService {
  String get baseUrl;

  Future<dynamic> get(String path,
      {Map<String, dynamic>? params,
      JsonType responseType = JsonType.CUSTOM_RESPONSE}) async {
    final response = await RestClient.getDio(customUrl: baseUrl)
        .get(path, queryParameters: params);
    return _handleResponse(response, responseType: responseType);
  }

  Future<dynamic> post(String path,
      {data,
      bool enableCache = false,
      JsonType responseType = JsonType.CUSTOM_RESPONSE}) async {
    final response =
        await RestClient.getDio(customUrl: baseUrl).post(path, data: data);
    return _handleResponse(response, responseType: responseType);
  }

  Future<dynamic> patch(String path,
      {data, JsonType responseType = JsonType.CUSTOM_RESPONSE}) async {
    final response =
        await RestClient.getDio(customUrl: baseUrl).patch(path, data: data);
    return _handleResponse(response, responseType: responseType);
  }

  Future<dynamic> put(String path,
      {data, JsonType responseType = JsonType.CUSTOM_RESPONSE}) async {
    final response =
        await RestClient.getDio(customUrl: baseUrl).put(path, data: data);
    return _handleResponse(response, responseType: responseType);
  }

  Future<dynamic> delete(String path,
      {data, JsonType responseType = JsonType.CUSTOM_RESPONSE}) async {
    final response =
        await RestClient.getDio(customUrl: baseUrl).delete(path, data: data);
    return _handleResponse(response, responseType: responseType);
  }

  Future<dynamic> postUpload(String path,
      {data, JsonType responseType = JsonType.CUSTOM_RESPONSE}) async {
    final response = await RestClient.getDio(isUpload: true, customUrl: baseUrl)
        .post(path, data: data);
    return _handleResponse(response, responseType: responseType);
  }

  Future<dynamic> postCustomUrl(
    String path, {
    String? customUrl,
    data,
    JsonType responseType = JsonType.CUSTOM_RESPONSE,
  }) async {
    final response =
        await RestClient.getDio(customUrl: customUrl).post(path, data: data);
    return _handleResponse(response, responseType: responseType);
  }

  bool isSuccess(statusCode) => statusCode! >= 200 && statusCode! <= 299;

  dynamic _handleResponse(dio.Response response,
      {JsonType responseType = JsonType.CUSTOM_RESPONSE});

  String queryParam(String? id) {
    Map<String, String?> queryParams = {'status': 'ACTIVE', 'root': id};
    return jsonEncode(queryParams);
  }
}

class AService extends IBaseService {
  @override
  String get baseUrl => "test";

  @override
  dynamic _handleResponse(dio.Response response,
      {JsonType responseType = JsonType.CUSTOM_RESPONSE}) {
    Logger.e('_handleResponse::' + response.toString());
    if (isSuccess(response.statusCode)) {
      if (responseType == JsonType.JSON_RESPONSE) {
        return ApiResponse.fromJson(response.data).data;
      } else if (responseType == JsonType.FULL_RESPONSE) {
        return response.data;
      } else if (responseType == JsonType.STRING_RESPONSE) {
        return ApiResponse(
            statusCode: response.statusCode,
            message: response.data,
            error: response.data);
      } else if (responseType == JsonType.BODY_BYTES) {
        return ApiResponse(
            statusCode: response.statusCode,
            message: response.data,
            error: response.data);
      } else if (responseType == JsonType.CUSTOM_RESPONSE) {
        return CustomResponse.fromJson(response.data).data;
      } else {
        return DataException.fromJson(jsonDecode(response.data));
      }
    } else {
      Logger.e('DataException:' + response.data.toString());
      return DataException.fromJson(jsonDecode(response.data));
    }
  }
}

class BService extends IBaseService {
  @override
  String get baseUrl => "base urlB";

  @override
  _handleResponse(dio.Response response,
      {JsonType responseType = JsonType.CUSTOM_RESPONSE}) {
    throw UnimplementedError();
  }
}

abstract class TargetType {
  String get baseUrl;
  String get path;
}

enum ServiceA {
  test1,
  test2;

  String get baseUrl {
    switch (this) {
      case ServiceA.test1:
        return "";
      case ServiceA.test2:
        return "";
    }
  }

  String get path {
    switch (this) {
      case ServiceA.test1:
        return "";
      case ServiceA.test2:
        return "";
    }
  }

  dynamic get task {
    switch (this) {
      case ServiceA.test1:
        return "";
      case ServiceA.test2:
        return "";
    }
  }
}
