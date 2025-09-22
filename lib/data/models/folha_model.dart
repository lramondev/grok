class FolhaModel {
  final int id;
  final String descricao;

  FolhaModel({
    required this.id,
    required this.descricao
  });

  factory FolhaModel.fromJson(Map<String, dynamic> json) {
    return FolhaModel(
      id: json['id'],
      descricao: json['descricao']
    );
  }
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'descricao': descricao
  };
}