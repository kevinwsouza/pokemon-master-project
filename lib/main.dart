import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pokemon_master_project.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(const PokemonMasterProject());
  });
}
