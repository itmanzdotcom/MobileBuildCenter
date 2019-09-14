import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' show Response, Client;

import 'exceptions.dart';

import 'package:tiki_app_testing/utils/constants.dart';

abstract class BaseApiClient {
  final String _baseUrl = Constants.baseUrl;
  final _httpClient = Client();

  Future<dynamic> get(String path, [Map<String, dynamic> headers]);
  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorizedException(response.body.toString());
      case 500:
        throw FetchDataException('Internal Server Error: ${response.statusCode}');
    }
  }
}

class ApiClient extends BaseApiClient {
  @override
  Future<dynamic> get(String path, [Map<String, dynamic> headers]) async {
    var responseJson;
    try {
      final response = await _httpClient.get(_baseUrl + path);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No internet connection');
    }
    return responseJson;
  }
}
