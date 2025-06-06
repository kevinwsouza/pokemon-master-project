import '../data/model/pokemon_details_model.dart';
import '../data/pokemon_details_repository.dart';
import 'pokemon_details_usecases.dart';

class PokemonDetailsUseCasesImpl implements PokemonDetailsUseCases {
  final PokemonDetailsRepository repository;

  PokemonDetailsUseCasesImpl(this.repository);

  @override
  Future<PokemonDetailsModel> fetchDetails(int id) {
    return repository.fetchDetails(id);
  }
}
