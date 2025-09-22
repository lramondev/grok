import 'dart:io';
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:grok/data/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart' as http_io;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '/core/config/environment_config.dart';
import '/core/network/network_exception.dart';

class ApiClient {
  final http.Client client;
  final storage = const FlutterSecureStorage();

  ApiClient(this.client);

  factory ApiClient.create() {
    final client = http.Client();
    return ApiClient(client);
  }

  static Future<http.Client> createCustomHttpClient() async {
    final certificateBytes = await rootBundle.load('assets/ca/barao.crt');
    final securityContext = SecurityContext()
      ..useCertificateChainBytes(certificateBytes.buffer.asUint8List());
    final httpClient = HttpClient(context: securityContext)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        return true;
      };
    return http_io.IOClient(httpClient);
  }

  Future<Map<String, String>> _getHeaders() async {
    final userData = await storage.read(key: 'user');
    String? token;
    if(userData != null) {
      UserModel user = UserModel.fromJson(jsonDecode(userData));
      token = user.token;
    }
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
  }

  Future<dynamic> get(String endpoint, { Map<String, dynamic>? queryParameters }) async {
    try {
      final uri = Uri.parse('${EnvironmentConfig.instance.apiUrl}$endpoint').replace(
        queryParameters: queryParameters?.map((key, value) => MapEntry(key, value.toString()))
      );
      final headers = await _getHeaders();
      final response = await client.get(uri, headers: headers).timeout(Duration(seconds: 10));
      return _handleResponse(response);
    } catch (e) {
      if (e is http.ClientException) {
        throw ConnectionException(
          message: 'Network error: ${e.message}',
          statusCode: null,
        );
      }
      rethrow;
    }
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic>? body) async {
    try {
      final headers = await _getHeaders();
      final uri = Uri.parse('${EnvironmentConfig.instance.apiUrl}$endpoint');
      final response = await client
        .post(uri, headers: headers, body: jsonEncode(body))
        .timeout(Duration(seconds: 10));
      return _handleResponse(response);
    } catch (e) {
      if (e is http.ClientException) {
        throw ConnectionException(
          message: 'Network error: ${e.message}',
          statusCode: null,
        );
      }
      rethrow;
    }
  }

  dynamic _handleResponse(http.Response response) {
    final statusCode = response.statusCode;
    final responseBody = response.body.isNotEmpty ? jsonDecode(response.body) : null;
    final errorDetails = responseBody is Map ? Map<String, dynamic>.from(responseBody) : null;

    switch (statusCode) {
      case 200:
      case 201:
        return responseBody;
      case 400:
        throw BadRequestException(
          message: 'Erro no processamento',
          statusCode: statusCode,
          errorDetails: errorDetails,
        );
      case 401:
        throw UnauthorizedException(
          message: responseBody,
          statusCode: statusCode,
          errorDetails: errorDetails,
        );
      case 403:
        throw ForbiddenException(
          message: responseBody,
          statusCode: statusCode,
          errorDetails: errorDetails,
        );
      case 404:
        throw BadRequestException(
          message: 'Rota não encontrada',
          statusCode: statusCode,
          errorDetails: errorDetails,
        );
      case 500:
      case 502:
      case 503:
      case 504:
        throw ServerException(
          message: 'Erro interno. Contate o suporte.',
          statusCode: statusCode,
          errorDetails: errorDetails,
        );
      default:
        throw NetworkException(
          message: 'Errp desconhecido. Contate o suporte.',
          statusCode: statusCode,
          errorDetails: errorDetails,
        );
    }
  }
}