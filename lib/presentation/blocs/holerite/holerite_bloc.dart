import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:grok/presentation/blocs/holerite/holerite_event.dart';
import 'package:grok/presentation/blocs/holerite/holerite_state.dart';

import 'package:grok/data/repositories/holerite_repository.dart';

class HoleriteBloc extends Bloc<HoleriteEvent, HoleriteState> {
  final HoleriteRepository holeriteRepository;

  HoleriteBloc(this.holeriteRepository) : super(HoleriteInitial()) {
    on<LoadHolerites>(_onLoadHolerites);
  }

  Future<void> _onLoadHolerites(
    LoadHolerites event,
    Emitter<HoleriteState> emit,
  ) async {
    emit(HoleriteLoading());
    try {
      final holerites = await holeriteRepository.list();
      emit(HoleriteLoaded(holerites));
    } catch (e) {
      emit(HoleriteError(e.toString()));
    }
  }

}