import 'dart:convert';

import 'package:grok/core/network/api_client.dart';

import 'package:grok/data/models/ponto_model.dart';
import 'package:grok/data/models/ponto_registro_model.dart';

class PontoRepository {
  final ApiClient apiClient;

  PontoRepository(this.apiClient);

  Future<List<PontoModel>> list() async {
    final response = await apiClient.get('mobile/ponto/list');
    final List<dynamic> data = response;
    return data.map((json) => PontoModel.fromJson(json)).toList();
  }

  Future<PontoRegistroModel> registro(PontoModel? ponto) async {
    final queryParameters = <String, dynamic>{};
    if(ponto != null) {
      queryParameters['ponto'] = jsonEncode(ponto);
    }
    final response = await apiClient.get('mobile/ponto/registro', queryParameters: queryParameters);
    return PontoRegistroModel.fromJson(response);
  }
}