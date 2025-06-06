import '../data/model/pokemon_list_result.dart';
import '../data/pokemon_list_repository.dart';
import 'pokemon_list_usecases.dart';

class PokemonListUseCasesImpl implements PokemonListUseCases {
  final PokemonListRepository repository;

  PokemonListUseCasesImpl(this.repository);

  @override
  Future<PokemonListResult> fetchPokemonList({int offset = 0, int limit = 20}) {
    return repository.fetchPokemonList(offset: offset, limit: limit);
  }
}
