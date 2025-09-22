import 'package:grok/data/models/evento_tipo_model.dart';

class EventoModel {
  final int id;
  final EventoTipoModel evento_tipo;
  final double quantidade;
  final double valor;
  final String data_inicio;
  final String? data_fim;
  final String? observacao;

  EventoModel({
    required this.id,
    required this.evento_tipo,
    required this.quantidade,
    required this.valor,
    required this.data_inicio,
    this.data_fim,
    this.observacao
  });

  factory EventoModel.fromJson(Map<String, dynamic> json) {
    return EventoModel(
      id: json['id'],
      evento_tipo: EventoTipoModel.fromJson(json['evento_tipo']),
      quantidade: double.parse(json['quantidade'].toString()),
      valor: double.parse(json['valor'].toString()),
      data_inicio: json['data_inicio'],
      data_fim: json['data_fim'],
      observacao: json['observacao']
    );
  }
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'evento_tipo': evento_tipo,
    'quantidade': quantidade,
    'valor': valor,
    'data_inicio': data_inicio,
    'data_fim': data_fim,
    'observacao': observacao
  };
}