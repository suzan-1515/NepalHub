import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:samachar_hub/core/constants/api_url_constants.dart';
import 'package:samachar_hub/core/exceptions/app_exceptions.dart';
import 'package:samachar_hub/core/network/http_manager/http_manager.dart';

const timeout = Duration(seconds: 15);

class AppHttpManager implements HttpManager {
  Dio dio;
  AppHttpManager() {
    BaseOptions options = BaseOptions(
      baseUrl: APIUrlConstants.BASE_API_URL,
      connectTimeout: 20000,
      receiveTimeout: 20000,
    );
    this.dio = Dio(options);
    // dio.interceptors.add(LogInterceptor(
    //     responseBody: true, requestBody: true, requestHeader: true));
  }

  @override
  Future get({
    String path,
    Map<String, dynamic> query,
    Map<String, String> headers,
  }) async {
    final response = await dio.get(
      path,
      queryParameters: _filterNullOrEmptyValuesFromMap(query),
      options: Options(
        headers: _filterNullOrEmptyValuesFromMap(headers),
        responseType: ResponseType.json,
      ),
    );

    return _returnResponse(response);
  }

  @override
  Future<dynamic> post({
    String path,
    Map body,
    Map<String, dynamic> query,
    Map<String, String> headers,
  }) async {
    final response = await dio.post(
      path,
      data: _filterNullOrEmptyValuesFromMap(body),
      queryParameters: _filterNullOrEmptyValuesFromMap(query),
      options: Options(
        headers: _filterNullOrEmptyValuesFromMap(headers),
        responseType: ResponseType.json,
      ),
    );

    return _returnResponse(response);
  }

  @override
  Future<dynamic> put({
    String url,
    Map body,
    Map<String, dynamic> query,
    Map<String, String> headers,
  }) async {
    final response = await dio.put(
      url,
      data: _filterNullOrEmptyValuesFromMap(body),
      queryParameters: _filterNullOrEmptyValuesFromMap(query),
      options: Options(
        headers: _filterNullOrEmptyValuesFromMap(headers),
        responseType: ResponseType.json,
      ),
    );

    return _returnResponse(response);
  }

  @override
  Future<dynamic> delete({
    String url,
    Map<String, dynamic> query,
    Map<String, String> headers,
  }) async {
    final response = await dio.delete(url,
        queryParameters: _filterNullOrEmptyValuesFromMap(query),
        options: Options(
          headers: _filterNullOrEmptyValuesFromMap(headers),
          responseType: ResponseType.json,
        ));

    return _returnResponse(response);
  }

  Map<String, String> _headerBuilder(Map<String, String> headers) {
    final headers = <String, String>{};
    headers[HttpHeaders.acceptHeader] = 'application/json';
    headers[HttpHeaders.contentTypeHeader] = 'application/json';
    if (headers != null && headers.isNotEmpty) {
      headers.forEach((key, value) {
        headers[key] = value;
      });
    }
    return headers;
  }

  String _queryBuilder(String path, Map<String, String> query) {
    final buffer = StringBuffer()..write(path);
    if (query != null) {
      if (query.isNotEmpty) {
        buffer.write('?');
      }
      query.forEach((key, value) {
        buffer.write('$key=$value&');
      });
    }
    return buffer.toString();
  }

  dynamic _returnResponse(Response response) {
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return response.data;
    }
    switch (response.statusCode) {
      case 400:
        throw BadRequestException();
      case 401:
      case 403:
        throw UnauthorisedException();
      case 500:
      default:
        throw ServerException();
    }
  }

  Map<String, dynamic> _filterNullOrEmptyValuesFromMap(
      Map<String, dynamic> map) {
    final Map<String, dynamic> filteredMap = <String, dynamic>{};
    map?.forEach((String key, dynamic value) {
      if (value != null && value.isNotEmpty) filteredMap[key] = value;
    });
    return filteredMap;
  }
}
