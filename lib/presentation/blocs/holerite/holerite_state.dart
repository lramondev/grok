import 'package:equatable/equatable.dart';

import 'package:grok/data/models/holerite_model.dart';

abstract class HoleriteState extends Equatable {
  @override
  List<Object> get props => [];
}

class HoleriteInitial extends HoleriteState {}

class HoleriteLoading extends HoleriteState {}

class HoleriteLoaded extends HoleriteState {
  final List<HoleriteModel> holerites;

  HoleriteLoaded(this.holerites);

  @override
  List<Object> get props => [ holerites ];
}

class HoleriteError extends HoleriteState {
  final String message;
  HoleriteError(this.message);
}
