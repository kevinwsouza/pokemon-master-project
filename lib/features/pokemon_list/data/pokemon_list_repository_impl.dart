import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../shared/configuration.dart';
import 'model/pokemon_list_model.dart';
import 'model/pokemon_list_result.dart';
import 'pokemon_list_repository.dart';

class PokemonListRepositoryImpl implements PokemonListRepository {
  @override
  Future<PokemonListResult> fetchPokemonList(
      {int offset = 0, int limit = 20}) async {
    final url = '${Configuration.baseUrl}?offset=$offset&limit=$limit';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List;
      final pokemons = results.map((e) => PokemonListItem.fromJson(e)).toList();
      final nextUrl = data['next'] as String?;
      return PokemonListResult(pokemons: pokemons, nextUrl: nextUrl);
    } else {
      throw Exception('Failed to load Pokémon list');
    }
  }
}
