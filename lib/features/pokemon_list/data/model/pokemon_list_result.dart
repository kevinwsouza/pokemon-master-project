import 'pokemon_list_model.dart';

class PokemonListResult {
  final List<PokemonListItem> pokemons;
  final String? nextUrl;

  PokemonListResult({required this.pokemons, required this.nextUrl});
}
