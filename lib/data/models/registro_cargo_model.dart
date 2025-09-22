import 'package:grok/data/models/cargo_model.dart';

class RegistroCargoModel {
  final int id;
  final String data_inicio;
  final String? data_fim;
  final CargoModel cargo;

  RegistroCargoModel({
    required this.id,
    required this.data_inicio,
    this.data_fim,
    required this.cargo
  });

  factory RegistroCargoModel.fromJson(Map<String, dynamic> json) {
    return RegistroCargoModel(
      id: json['id'],
      data_inicio: json['data_inicio'],
      data_fim: json['data_fim'],
      cargo: CargoModel.fromJson(json['cargo'])
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'data_inicio': data_inicio,
    'data_fim': data_fim,
    'cargo': cargo
  };
}