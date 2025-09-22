import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthCheck extends AuthEvent {}

class AuthLogin extends AuthEvent {
  final String cpf;
  final String password;
  final bool rememberMe;

  AuthLogin(this.cpf, this.password, { this.rememberMe = false });

  @override
  List<Object> get props => [ cpf, password, rememberMe ];
}

class AuthProfile extends AuthEvent {}

class AuthLogout extends AuthEvent {}