class PessoaModel {
  final int id;
  final String nome_razao_social;
  final String apelido_fantasia;
  final String cpf_cnpj;
  final String? foto_url;

  PessoaModel({
    required this.id,
    required this.nome_razao_social,
    required this.apelido_fantasia,
    required this.cpf_cnpj,
    this.foto_url
  });

  factory PessoaModel.fromJson(Map<String, dynamic> json) {
    return PessoaModel(
      id: json['id'],
      nome_razao_social: json['nome_razao_social'],
      apelido_fantasia: json['apelido_fantasia'],
      cpf_cnpj: json['cpf_cnpj'],
      foto_url: json['foto_url'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome_razao_social': nome_razao_social,
    'apelido_fantasia': apelido_fantasia,
    'cpf_cnpj': cpf_cnpj,
    'foto_url': foto_url
  };
} 