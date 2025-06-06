import 'package:flutter/material.dart';

import 'shared/routes/router_register.dart';

class PokemonMasterProject extends StatelessWidget {
  const PokemonMasterProject({super.key});

  @override
  Widget build(BuildContext context) {
    final routerInstance = RouterRegister.getInstance().router;

    return MaterialApp.router(
      title: 'Flutter Bloc',
      routerConfig: routerInstance,
      debugShowCheckedModeBanner: false,
    );
  }
}
