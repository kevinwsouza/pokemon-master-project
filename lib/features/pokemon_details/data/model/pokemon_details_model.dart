class PokemonDetailsModel {
  final int id;
  final String name;
  final List<String> abilities;
  final List<String> types;
  final int height;
  final int weight;
  final String frontDefault;

  PokemonDetailsModel({
    required this.id,
    required this.name,
    required this.abilities,
    required this.types,
    required this.height,
    required this.weight,
    required this.frontDefault,
  });

  factory PokemonDetailsModel.fromJson(Map<String, dynamic> json) {
    return PokemonDetailsModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      abilities: (json['abilities'] as List<dynamic>)
          .map((a) => a['ability']['name'] as String)
          .toList(),
      types: (json['types'] as List<dynamic>)
          .map((t) => t['type']['name'] as String)
          .toList(),
      height: json['height'] ?? 0,
      weight: json['weight'] ?? 0,
      frontDefault: json['sprites']?['front_default'] ?? '',
    );
  }
}
