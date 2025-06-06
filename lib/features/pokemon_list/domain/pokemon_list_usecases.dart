import '../data/model/pokemon_list_result.dart';

abstract class PokemonListUseCases {
  Future<PokemonListResult> fetchPokemonList({int offset = 0, int limit = 20});
}
