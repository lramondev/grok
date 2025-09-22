import 'package:equatable/equatable.dart';
import 'package:grok/data/models/holerite_model.dart';

abstract class HoleriteDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadDetail extends HoleriteDetailEvent {
  final HoleriteModel holerite;

  LoadDetail({
    required this.holerite
  });

  @override
  List<Object?> get props => [ holerite ];
}

class SignHolerite extends HoleriteDetailEvent {
  final HoleriteModel holerite;
  
  SignHolerite(this.holerite);

  @override
  List<Object?> get props => [ holerite ];
}

class PrintHolerite extends HoleriteDetailEvent {
  final HoleriteModel holerite;
  PrintHolerite(this.holerite);
}
