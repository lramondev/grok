import 'package:grok/data/models/folha_model.dart';
import 'package:grok/data/models/registro_model.dart';
import 'package:grok/data/models/status_model.dart';

class HoleriteModel {
  final int id;
  final FolhaModel folha;
  final RegistroModel registro;
  final String? datahora_assinatura;
  final double total;
  final StatusModel status;

  HoleriteModel({
    required this.id,
    required this.folha,
    required this.registro,
    this.datahora_assinatura,
    required this.total,
    required this.status
  });

  factory HoleriteModel.fromJson(Map<String, dynamic> json) {
    return HoleriteModel(
      id: json['id'],
      folha: FolhaModel.fromJson(json['folha']),
      registro: RegistroModel.fromJson(json['registro']),
      datahora_assinatura: json['datahora_assinatura'],
      total: double.parse(json['total'].toString()),
      status: StatusModel.fromJson(json['status'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'folha': folha,
      'registro': registro,
      'datahora_assinatura': datahora_assinatura,
      'total': total,
      'status': status
    };
  }
}