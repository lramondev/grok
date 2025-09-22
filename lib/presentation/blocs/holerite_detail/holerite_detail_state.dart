import 'dart:io';

import 'package:equatable/equatable.dart';

import 'package:grok/data/models/evento_model.dart';
import 'package:grok/data/models/holerite_model.dart';

abstract class HoleriteDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class HoleriteDetailInitial extends HoleriteDetailState {}

class HoleriteDetailLoading extends HoleriteDetailState {}

class HoleriteDetailLoaded extends HoleriteDetailState {
  final List<EventoModel> eventos;

  HoleriteDetailLoaded(this.eventos);

  @override
  List<Object> get props => [ eventos ];
}

class HoleriteSigned extends HoleriteDetailState {
  final HoleriteModel holerite;
  
  HoleriteSigned(this.holerite);

  @override
  List<Object> get props => [ holerite ];
}

class HoleriteDetailPrinted extends HoleriteDetailState {
  final File file;
  HoleriteDetailPrinted(this.file);
}

class HoleriteDetailError extends HoleriteDetailState {
  final String message;
  HoleriteDetailError(this.message);
}