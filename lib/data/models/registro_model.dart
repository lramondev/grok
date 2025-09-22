import 'package:grok/data/models/pessoa_model.dart';
import 'package:grok/data/models/registro_cargo_model.dart';

class RegistroModel {
  final int id;
  final String data_inicio;
  final String? data_fim;
  final RegistroCargoModel registro_cargo;
  final PessoaModel funcionario;

  RegistroModel({
    required this.id,
    required this.data_inicio,
    this.data_fim,
    required this.registro_cargo,
    required this.funcionario
  });

  factory RegistroModel.fromJson(Map<String, dynamic> json) {
    return RegistroModel(
      id: json['id'],
      data_inicio: json['data_inicio'],
      data_fim: json['data_fim'],
      registro_cargo: RegistroCargoModel.fromJson(json['registro_cargo']),
      funcionario: PessoaModel.fromJson(json['funcionario'])
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'data_inicio': data_inicio,
    'data_fim': data_fim,
    'registro_cargo': registro_cargo,
    'funcionario': funcionario
  };
}