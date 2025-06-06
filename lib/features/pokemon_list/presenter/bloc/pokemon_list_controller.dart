import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/pokemon_list_model.dart';
import 'pokemon_list_state.dart';
import '../../domain/pokemon_list_usecases.dart';

class PokemonListController extends Cubit<PokemonListState> {
  final PokemonListUseCases useCases;

  List<PokemonListItem> _pokemons = [];
  String? _nextUrl;
  bool _isLoadingMore = false;

  PokemonListController(this.useCases) : super(PokemonListInitialState());

  Future<void> fetchPokemonList() async {
    emit(PokemonListLoadingState());
    try {
      final result = await useCases.fetchPokemonList();
      _pokemons = result.pokemons;
      _nextUrl = result.nextUrl;
      emit(PokemonListSuccessState(_pokemons, nextUrl: _nextUrl));
    } catch (e) {
      emit(PokemonListErrorState(e.toString()));
    }
  }

  Future<void> fetchMorePokemons() async {
    if (_nextUrl == null || _isLoadingMore) return;
    _isLoadingMore = true;
    emit(PokemonListSuccessState(_pokemons,
        nextUrl: _nextUrl, isLoadingMore: true));
    try {
      final uri = Uri.parse(_nextUrl!);
      final offset = int.tryParse(uri.queryParameters['offset'] ?? '0') ?? 0;
      final limit = int.tryParse(uri.queryParameters['limit'] ?? '20') ?? 20;
      final result =
          await useCases.fetchPokemonList(offset: offset, limit: limit);
      _pokemons.addAll(result.pokemons);
      _nextUrl = result.nextUrl;
      _isLoadingMore = false;
      emit(PokemonListSuccessState(_pokemons, nextUrl: _nextUrl));
    } catch (e) {
      _isLoadingMore = false;
      emit(PokemonListErrorState(e.toString()));
    }
  }
}
