import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/pokemon_details_usecases.dart';
import 'pokemon_details_state.dart';

class PokemonDetailsController extends Cubit<PokemonDetailsState> {
  final PokemonDetailsUseCases useCases;

  PokemonDetailsController(this.useCases) : super(PokemonDetailsInitial());

  Future<void> fetchDetails(int id) async {
    emit(PokemonDetailsLoading());
    try {
      final data = await useCases.fetchDetails(id);
      emit(PokemonDetailsSuccess(data));
    } catch (e) {
      emit(PokemonDetailsError(e.toString()));
    }
  }
}
