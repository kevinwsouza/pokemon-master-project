import 'model/pokemon_details_model.dart';

abstract class PokemonDetailsRepository {
  Future<PokemonDetailsModel> fetchDetails(int id);
}
