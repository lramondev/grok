import 'package:equatable/equatable.dart';

abstract class HoleriteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadHolerites extends HoleriteEvent {}
