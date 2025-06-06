import '../data/model/pokemon_details_model.dart';

abstract class PokemonDetailsUseCases {
  Future<PokemonDetailsModel> fetchDetails(int id);
}
