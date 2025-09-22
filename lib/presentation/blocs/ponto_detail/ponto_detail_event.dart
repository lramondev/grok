import 'package:equatable/equatable.dart';

import 'package:grok/data/models/ponto_model.dart';

abstract class PontoDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadDetail extends PontoDetailEvent {
  final PontoModel ponto;

  LoadDetail({
    required this.ponto
  });

  @override
  List<Object?> get props => [ ponto ];
}
