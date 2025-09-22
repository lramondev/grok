import 'package:equatable/equatable.dart';

abstract class PontoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadPontos extends PontoEvent {}
