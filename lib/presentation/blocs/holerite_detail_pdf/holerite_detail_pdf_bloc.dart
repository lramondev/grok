import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:grok/data/repositories/holerite_repository.dart';

import 'package:grok/presentation/blocs/holerite_detail_pdf/holerite_detail_pdf_event.dart';
import 'package:grok/presentation/blocs/holerite_detail_pdf/holerite_detail_pdf_state.dart';

import 'package:path_provider/path_provider.dart';

class HoleriteDetailPdfBloc extends Bloc<HoleriteDetailPdfEvent, HoleriteDetailPdfState> {
  final HoleriteRepository holeriteRepository;

  HoleriteDetailPdfBloc(this.holeriteRepository) : super(HoleriteDetailPdfInitial()) {
    on<PrintHolerite>(_onPrintHolerite);
  }

  Future<void> _onPrintHolerite(
    PrintHolerite event,
    Emitter<HoleriteDetailPdfState> emit,
  ) async {
    emit(HoleriteDetailPdfLoading());
    try {
      final String base64 = await holeriteRepository.print(event.holerite);
      final bytes = base64Decode(base64);
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/holerite_${event.holerite.id}.pdf');
      await file.writeAsBytes(bytes);
      emit(HoleriteDetailPdfPrinted(file));
    } catch (e) {
      emit(HoleriteDetailPdfError(e.toString()));
    }
  }

}