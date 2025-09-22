import 'package:grok/data/models/registro_model.dart';

class UserModel {
  final int id;
  final RegistroModel registro;
  final String? imei;
  final String? password;
  final String? token;
  final String? last_login;

  UserModel({
    required this.id,
    required this.registro,
    this.imei,
    this.password,
    this.token,
    this.last_login
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      registro: RegistroModel.fromJson(json['registro']),
      imei: json['imei'],
      password: json['password'],
      token: json['token'],
      last_login: json['last_login'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'registro': registro,
    'imei': imei,
    'password': password,
    'token': token,
    'last_login': last_login
  };
}
