import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class HoleriteDetailPdfState extends Equatable {
  @override
  List<Object> get props => [];
}

class HoleriteDetailPdfInitial extends HoleriteDetailPdfState {}

class HoleriteDetailPdfLoading extends HoleriteDetailPdfState {}

class HoleriteDetailPdfPrinted extends HoleriteDetailPdfState {
  final File file;
  HoleriteDetailPdfPrinted(this.file);
}

class HoleriteDetailPdfError extends HoleriteDetailPdfState {
  final String message;
  HoleriteDetailPdfError(this.message);
}