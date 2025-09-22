import 'package:equatable/equatable.dart';

import 'package:grok/data/models/ponto_registro_model.dart';

abstract class PontoDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class PontoDetailInitial extends PontoDetailState {}

class PontoDetailLoading extends PontoDetailState {}

class PontoDetailLoaded extends PontoDetailState {
  final PontoRegistroModel registro;

  PontoDetailLoaded(this.registro);

  @override
  List<Object> get props => [ registro ];
}

class PontoDetailError extends PontoDetailState {
  final String message;
  PontoDetailError(this.message);
}