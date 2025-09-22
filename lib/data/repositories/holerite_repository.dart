import 'dart:convert';

import 'package:grok/core/network/api_client.dart';
import 'package:grok/data/models/holerite_model.dart';
import 'package:grok/data/models/evento_model.dart';

class HoleriteRepository {
  final ApiClient apiClient;

  HoleriteRepository(this.apiClient);

  Future<List<HoleriteModel>> list() async {
    final response = await apiClient.get('mobile/holerite/list');
    final List<dynamic> data = response;
    return data.map((json) => HoleriteModel.fromJson(json)).toList();
  }

  Future<List<EventoModel>> detail(HoleriteModel? holerite) async {
    final queryParameters = <String, dynamic>{};
    if(holerite != null) {
      queryParameters['holerite'] = jsonEncode(holerite);
    }
    final response = await apiClient.get('mobile/holerite/detail', queryParameters: queryParameters);
    final List<dynamic> data = response;
    return data.map((json) => EventoModel.fromJson(json)).toList();
  }
  
  Future<HoleriteModel> sign(HoleriteModel holerite) async {
    final response = await apiClient.post('mobile/holerite/sign', { 'holerite': holerite });
    return HoleriteModel.fromJson(response);
  }

  Future<String> print(HoleriteModel holerite) async {
    final response = await apiClient.post('mobile/holerite/print', { 'holerite': holerite });
    final String data = response['data'];
    return data;
  }
}