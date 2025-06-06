import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model/pokemon_details_model.dart';
import 'pokemon_details_repository.dart';

class PokemonDetailsRepositoryImpl implements PokemonDetailsRepository {
  @override
  Future<PokemonDetailsModel> fetchDetails(int id) async {
    final response =
        await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return PokemonDetailsModel.fromJson(data);
    } else {
      throw Exception('Erro ao buscar detalhes do Pokémon');
    }
  }
}
