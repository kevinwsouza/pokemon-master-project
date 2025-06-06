import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/pokemon_app_bar.dart';
import '../bloc/pokemon_details_controller.dart';
import '../bloc/pokemon_details_state.dart';
import '../../data/pokemon_details_repository_impl.dart';
import '../../domain/pokemon_details_usecases_impl.dart';
import 'package:intl/intl.dart';

class PokemonDetailsScreen extends StatelessWidget {
  final int pokemonId;
  const PokemonDetailsScreen({super.key, required this.pokemonId});

  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter = NumberFormat.decimalPattern();

    return BlocProvider(
      create: (_) => PokemonDetailsController(
        PokemonDetailsUseCasesImpl(PokemonDetailsRepositoryImpl()),
      )..fetchDetails(pokemonId),
      child: BlocBuilder<PokemonDetailsController, PokemonDetailsState>(
        builder: (context, state) {
          String title = 'Detalhes';
          if (state is PokemonDetailsSuccess) {
            title = state.data.name.toUpperCase();
          }
          return Scaffold(
            appBar: PokemonAppBar(
              title: title,
              showBackButton: true,
            ),
            body: Builder(
              builder: (context) {
                if (state is PokemonDetailsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PokemonDetailsError) {
                  return Center(child: Text(state.message));
                } else if (state is PokemonDetailsSuccess) {
                  final data = state.data;
                  return Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            data.frontDefault,
                            width: 250,
                            height: 250,
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'ID: ',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${data.id}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'ABILITY: ',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  data.abilities.join(", "),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'TYPES: ',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  data.types.join(", "),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'HEIGHT: ',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${formatter.format(data.height / 10)} m',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'WEIGHT: ',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${formatter.format(data.weight / 10)} kg',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          );
        },
      ),
    );
  }
}
