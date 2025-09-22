import 'package:equatable/equatable.dart';

import 'package:grok/data/models/ponto_model.dart';

abstract class PontoState extends Equatable {
  @override
  List<Object> get props => [];
}

class PontoInitial extends PontoState {}

class PontoLoading extends PontoState {}

class PontoLoaded extends PontoState {
  final List<PontoModel> pontos;

  PontoLoaded(this.pontos);

  @override
  List<Object> get props => [ pontos ];
}

class PontoError extends PontoState {
  final String message;
  PontoError(this.message);
}
