import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:grok/data/repositories/ponto_repository.dart';

import 'package:grok/presentation/blocs/ponto_detail/ponto_detail_event.dart';
import 'package:grok/presentation/blocs/ponto_detail/ponto_detail_state.dart';

class PontoDetailBloc extends Bloc<PontoDetailEvent, PontoDetailState> {
  final PontoRepository pontoRepository;

  PontoDetailBloc(this.pontoRepository) : super(PontoDetailInitial()) {
    on<LoadDetail>(_onLoadRegistros);
  }

  Future<void> _onLoadRegistros(
    LoadDetail event,
    Emitter<PontoDetailState> emit,
  ) async {
    emit(PontoDetailLoading());
    try {
      final registro = await pontoRepository.registro(event.ponto);
      emit(PontoDetailLoaded(registro));
    } catch (e) {
      emit(PontoDetailError(e.toString()));
    }
  }

}