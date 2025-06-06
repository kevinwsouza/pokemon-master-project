import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_master_project/shared/routes/routes_app.dart';

class RouterRegister {
  static RouterRegister? _instance;
  static GlobalKey<NavigatorState> globalContext = GlobalKey<NavigatorState>();

  static RouterRegister getInstance() {
    return _instance ??= RouterRegister();
  }

  final RouterConfig<Object> router = GoRouter(
    navigatorKey: globalContext,
    initialLocation: '/',
    routes: <ShellRoute>[
      ShellRoute(
        builder: (context, state, child) => child,
        routes: [
          ...RoutesApp.getInstance().routes,
        ],
      )
    ],
  );
}
