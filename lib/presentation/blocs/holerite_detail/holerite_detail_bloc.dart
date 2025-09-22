import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:grok/data/repositories/holerite_repository.dart';

import 'package:grok/presentation/blocs/holerite_detail/holerite_detail_event.dart';
import 'package:grok/presentation/blocs/holerite_detail/holerite_detail_state.dart';

import 'package:path_provider/path_provider.dart';

class HoleriteDetailBloc extends Bloc<HoleriteDetailEvent, HoleriteDetailState> {
  final HoleriteRepository holeriteRepository;

  HoleriteDetailBloc(this.holeriteRepository) : super(HoleriteDetailInitial()) {
    on<LoadDetail>(_onLoadEventos);
    on<SignHolerite>(_onSignHolerite);
    on<PrintHolerite>(_onPrintHolerite);
  }

  Future<void> _onLoadEventos(
    LoadDetail event,
    Emitter<HoleriteDetailState> emit,
  ) async {
    emit(HoleriteDetailLoading());
    if(event.holerite.status.id == 1) {
      await holeriteRepository.sign(event.holerite);
    }
    try {
      final eventos = await holeriteRepository.detail(event.holerite);
      emit(HoleriteDetailLoaded(eventos));
    } catch (e) {
      emit(HoleriteDetailError(e.toString()));
    }
  }

  Future<void> _onSignHolerite(
    SignHolerite event,
    Emitter<HoleriteDetailState> emit,
  ) async {
    emit(HoleriteDetailLoading());
    try {
      if(event.holerite.status.id == 1) {
        await holeriteRepository.sign(event.holerite);
      }
      emit(HoleriteSigned(event.holerite));
    } catch (e) {
      emit(HoleriteDetailError(e.toString()));
    }
  }

  Future<void> _onPrintHolerite(
    PrintHolerite event,
    Emitter<HoleriteDetailState> emit,
  ) async {
    emit(HoleriteDetailLoading());
    try {
      final String base64 = await holeriteRepository.print(event.holerite);
      final bytes = base64Decode(base64);
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/holerite_${event.holerite.id}.pdf');
      await file.writeAsBytes(bytes);
      emit(HoleriteDetailPrinted(file));
    } catch (e) {
      emit(HoleriteDetailError(e.toString()));
    }
  }

}