import 'model/pokemon_list_result.dart';

abstract class PokemonListRepository {
  Future<PokemonListResult> fetchPokemonList({int offset = 0, int limit = 20});
}
