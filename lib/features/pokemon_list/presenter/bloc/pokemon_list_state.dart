import '../../data/model/pokemon_list_model.dart';

sealed class PokemonListState {}

final class PokemonListInitialState extends PokemonListState {}

final class PokemonListLoadingState extends PokemonListState {}

final class PokemonListErrorState extends PokemonListState {
  final String message;
  PokemonListErrorState(this.message);
}

final class PokemonListSuccessState extends PokemonListState {
  final List<PokemonListItem> pokemons;
  final String? nextUrl;
  final bool isLoadingMore;

  PokemonListSuccessState(this.pokemons,
      {this.nextUrl, this.isLoadingMore = false});
}
