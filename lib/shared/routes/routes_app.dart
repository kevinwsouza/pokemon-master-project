import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/pokemon_details/data/pokemon_details_repository_impl.dart';
import '../../features/pokemon_details/domain/pokemon_details_usecases_impl.dart';
import '../../features/pokemon_details/presenter/bloc/pokemon_details_controller.dart';
import '../../features/pokemon_details/presenter/pages/pokemon_details_screen.dart';
import '../../splash_screen.dart';
import '../../features/pokemon_list/data/pokemon_list_repository_impl.dart';
import '../../features/pokemon_list/domain/pokemon_list_usecases_impl.dart';
import '../../features/pokemon_list/presenter/bloc/pokemon_list_controller.dart';
import '../../features/pokemon_list/presenter/pages/pokemon_list_screen.dart';

class RoutesApp {
  static const String home = '/home';
  static const String details = '/details/:id';

  static RoutesApp? _instance;

  static RoutesApp getInstance() {
    return _instance ??= RoutesApp();
  }

  final routes = [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => MaterialPage(
        child: SplashScreen(),
      ),
    ),
    GoRoute(
      path: home,
      pageBuilder: (context, state) => MaterialPage(
        child: BlocProvider(
          create: (_) {
            final repository = PokemonListRepositoryImpl();
            final useCase = PokemonListUseCasesImpl(repository);
            return PokemonListController(useCase);
          },
          child: const PokemonListPage(),
        ),
      ),
    ),
    GoRoute(
      path: details,
      pageBuilder: (context, state) {
        final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
        return MaterialPage(
          child: BlocProvider(
            create: (_) => PokemonDetailsController(
              PokemonDetailsUseCasesImpl(PokemonDetailsRepositoryImpl()),
            )..fetchDetails(id),
            child: PokemonDetailsScreen(pokemonId: id),
          ),
        );
      },
    ),
  ];
}
