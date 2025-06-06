import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:pokemon_master_project/shared/pokemon_app_bar.dart';
import '../bloc/pokemon_list_controller.dart';
import '../bloc/pokemon_list_state.dart';
import '../components/pokemon_list_item.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key});

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<PokemonListController>().fetchPokemonList();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final controller = context.read<PokemonListController>();
      final state = controller.state;
      if (state is PokemonListSuccessState &&
          state.nextUrl != null &&
          !state.isLoadingMore) {
        controller.fetchMorePokemons();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PokemonAppBar(
        title: 'Pokémons',
        showBackButton: false,
      ),
      body: BlocBuilder<PokemonListController, PokemonListState>(
        builder: (context, state) {
          if (state is PokemonListLoadingState) {
            return Center(
              child: Lottie.asset(
                'assets/pokeball_animation.json',
                width: 120,
                height: 120,
                fit: BoxFit.contain,
              ),
            );
          } else if (state is PokemonListErrorState) {
            return Center(child: Text('Erro: ${state.message}'));
          } else if (state is PokemonListSuccessState) {
            final pokemons = state.pokemons;
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.separated(
                controller: _scrollController,
                itemCount:
                    state.isLoadingMore ? pokemons.length + 1 : pokemons.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  if (index >= pokemons.length) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Center(
                        child: Lottie.asset(
                          'assets/pokeball_animation.json',
                          width: 80,
                          height: 80,
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  }
                  final pokemon = pokemons[index];
                  return PokemonListItemWidget(
                    name: pokemon.name,
                    imageUrl: pokemon.imageUrl,
                    onTap: () {
                      GoRouter.of(context).go('/details/${pokemon.id}');
                    },
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
