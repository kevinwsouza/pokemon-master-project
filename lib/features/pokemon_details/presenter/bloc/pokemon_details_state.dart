import '../../data/model/pokemon_details_model.dart';

sealed class PokemonDetailsState {}

final class PokemonDetailsInitial extends PokemonDetailsState {}

final class PokemonDetailsLoading extends PokemonDetailsState {}

final class PokemonDetailsSuccess extends PokemonDetailsState {
  final PokemonDetailsModel data;
  PokemonDetailsSuccess(this.data);
}

final class PokemonDetailsError extends PokemonDetailsState {
  final String message;
  PokemonDetailsError(this.message);
}
