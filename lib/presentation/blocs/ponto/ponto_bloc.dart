import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:grok/presentation/blocs/ponto/ponto_event.dart';
import 'package:grok/presentation/blocs/ponto/ponto_state.dart';

import 'package:grok/data/repositories/ponto_repository.dart';

class PontoBloc extends Bloc<PontoEvent, PontoState> {
  final PontoRepository pontoRepository;

  PontoBloc(this.pontoRepository) : super(PontoInitial()) {
    on<LoadPontos>(_onLoadHolerites);
  }

  Future<void> _onLoadHolerites(
    LoadPontos event,
    Emitter<PontoState> emit,
  ) async {
    emit(PontoLoading());
    try {
      final pontos = await pontoRepository.list();
      emit(PontoLoaded(pontos));
    } catch (e) {
      emit(PontoError(e.toString()));
    }
  }

}