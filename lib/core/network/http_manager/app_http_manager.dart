import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:samachar_hub/core/exceptions/app_exceptions.dart';
import 'package:samachar_hub/core/network/http_manager/http_manager.dart';

const timeout = Duration(seconds: 15);

class AppHttpManager implements HttpManager {
  @override
  Future get({
    String url,
    Map<String, dynamic> query,
    Map<String, String> headers,
  }) async {
    print('Api Get request url $url');
    final response = await http
        .get(_queryBuilder(url, _filterNullOrEmptyValuesFromMap(query)),
            headers: _headerBuilder(_filterNullOrEmptyValuesFromMap(headers)))
        .timeout(timeout, onTimeout: () => throw TimeoutException());
    return _returnResponse(response);
  }

  @override
  Future<dynamic> post({
    String url,
    Map body,
    Map<String, dynamic> query,
    Map<String, String> headers,
  }) async {
    print('Api Post request url $url, with $body');
    final response = await http
        .post(_queryBuilder(url, _filterNullOrEmptyValuesFromMap(query)),
            body: body != null ? json.encode(body) : null,
            headers: _headerBuilder(_filterNullOrEmptyValuesFromMap(headers)))
        .timeout(timeout, onTimeout: () => throw TimeoutException());
    return _returnResponse(response);
  }

  @override
  Future<dynamic> put({
    String url,
    Map body,
    Map<String, dynamic> query,
    Map<String, String> headers,
  }) async {
    print('Api Put request url $url, with $body');
    final response = await http
        .put(_queryBuilder(url, _filterNullOrEmptyValuesFromMap(query)),
            body: json.encode(body),
            headers: _headerBuilder(_filterNullOrEmptyValuesFromMap(headers)))
        .timeout(timeout, onTimeout: () => throw TimeoutException());
    return _returnResponse(response);
  }

  @override
  Future<dynamic> delete({
    String url,
    Map<String, dynamic> query,
    Map<String, String> headers,
  }) async {
    print('Api Delete request url $url');
    final response = await http
        .delete(_queryBuilder(url, _filterNullOrEmptyValuesFromMap(query)),
            headers: _headerBuilder(_filterNullOrEmptyValuesFromMap(headers)))
        .timeout(timeout, onTimeout: () => throw TimeoutException());
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

  String _queryBuilder(String path, Map<String, dynamic> query) {
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

  dynamic _returnResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return json.decode(response.body);
    }
    print('Api response error with ${response.statusCode} + ${response.body}');
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

  Map<String, String> _filterNullOrEmptyValuesFromMap(Map<String, String> map) {
    final Map<String, String> filteredMap = <String, String>{};
    map.forEach((String key, String value) {
      if (value != null && value.isNotEmpty) filteredMap[key] = value;
    });
    return filteredMap;
  }
}
