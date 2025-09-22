import 'package:equatable/equatable.dart';
import 'package:grok/data/models/holerite_model.dart';

abstract class HoleriteDetailPdfEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PrintHolerite extends HoleriteDetailPdfEvent {
  final HoleriteModel holerite;
  PrintHolerite(this.holerite);
}
