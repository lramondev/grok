class CargoModel {
  final int id;
  final String descricao;

  CargoModel({
    required this.id,
    required this.descricao
  });

  factory CargoModel.fromJson(Map<String, dynamic> json) {
    return CargoModel(
      id: json['id'],
      descricao: json['descricao']
    );
  }
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'descricao': descricao
  };
}