class EventoTipoModel {
  final int id;
  final String descricao;

  EventoTipoModel({
    required this.id,
    required this.descricao
  });

  factory EventoTipoModel.fromJson(Map<String, dynamic> json) {
    return EventoTipoModel(
      id: json['id'],
      descricao: json['descricao']
    );
  }
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'descricao': descricao
  };
}