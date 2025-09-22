class PontoRegistroModel {
  final String data;
  final String dia_semana;

  final String primeira_hora_inicio;
  final String? registro_primeira_hora_inicio;
  final String status_primeira_hora_inicio;

  final String primeira_hora_fim;
  final String? registro_primeira_hora_fim;
  final String status_primeira_hora_fim;

  final String? segunda_hora_inicio;
  final String? registro_segunda_hora_inicio;
  final String? status_segunda_hora_inicio;

  final String? segunda_hora_fim;
  final String? registro_segunda_hora_fim;
  final String? status_segunda_hora_fim;

  PontoRegistroModel({
    required this.data,
    required this.dia_semana,

    required this.primeira_hora_inicio,
    this.registro_primeira_hora_inicio,
    required this.status_primeira_hora_inicio,

    required this.primeira_hora_fim,
    this.registro_primeira_hora_fim,
    required this.status_primeira_hora_fim,

    this.segunda_hora_inicio,
    this.registro_segunda_hora_inicio,
    this.status_segunda_hora_inicio,

    this.segunda_hora_fim,
    this.registro_segunda_hora_fim,
    this.status_segunda_hora_fim,
  });

  factory PontoRegistroModel.fromJson(Map<String, dynamic> json) {
    return PontoRegistroModel(
      data: json['data'],
      dia_semana: json['dia_semana'],

      primeira_hora_inicio: json['primeira_hora_inicio'],
      registro_primeira_hora_inicio: json['registro_primeira_hora_inicio'],
      status_primeira_hora_inicio: json['status_primeira_hora_inicio'],

      primeira_hora_fim: json['primeira_hora_fim'],
      registro_primeira_hora_fim: json['registro_primeira_hora_fim'],
      status_primeira_hora_fim: json['status_primeira_hora_fim'],

      segunda_hora_inicio: json['segunda_hora_inicio'],
      registro_segunda_hora_inicio: json['registro_segunda_hora_inicio'],
      status_segunda_hora_inicio: json['status_segunda_hora_inicio'],

      segunda_hora_fim: json['segunda_hora_fim'],
      registro_segunda_hora_fim: json['registro_segunda_hora_fim'],
      status_segunda_hora_fim: json['status_segunda_hora_fim'],
    );
  }
  
  Map<String, dynamic> toJson() => {
    'data': data,
    'dia_semana': dia_semana,
    'primeira_hora_inicio': primeira_hora_inicio,
    'registro_primeira_hora_inicio': registro_primeira_hora_inicio,
    'status_primeira_hora_inicio': status_primeira_hora_inicio,

    'primeira_hora_fim': primeira_hora_fim,
    'registro_primeira_hora_fim': registro_primeira_hora_fim,
    'status_primeira_hora_fim': status_primeira_hora_fim,

    'segunda_hora_inicio': segunda_hora_inicio,
    'registro_segunda_hora_inicio': registro_segunda_hora_inicio,
    'status_segunda_hora_inicio': status_segunda_hora_inicio,

    'segunda_hora_fim': segunda_hora_fim,
    'registro_segunda_hora_fim': registro_segunda_hora_fim,
    'status_segunda_hora_fim': status_segunda_hora_fim
  };
}