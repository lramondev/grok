class PontoModel {
  final String data;
  final int batidas;
  final int esperadas;
  final String resultado;

  PontoModel({
    required this.data,
    required this.batidas,
    required this.esperadas,
    required this.resultado
  });

  factory PontoModel.fromJson(Map<String, dynamic> json) {
    return PontoModel(
      data: json['data'],
      batidas: int.parse(json['batidas']),
      esperadas: int.parse(json['esperadas']),
      resultado: json['resultado']
    );
  }
  
  Map<String, dynamic> toJson() => {
    'data': data,
    'batidas': batidas,
    'esperadas': esperadas,
    'resultado': resultado
  };
}