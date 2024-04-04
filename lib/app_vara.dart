import 'package:app_vara/screens/error_screen.dart';
import 'package:app_vara/screens/home_screen.dart';
import 'package:app_vara/screens/main_screen.dart';
import 'package:app_vara/screens/map_screen.dart';
import 'package:app_vara/screens/photo_screen.dart';
import 'package:app_vara/screens/routes_screen.dart';
import 'package:app_vara/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();
final GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  routes: <RouteBase>[
    ShellRoute(
      navigatorKey: shellNavigatorKey,
      builder: (context, state, child) {
        return MainScreen(
          child: child,
        );
      },
      routes: [
        GoRoute(
          name: 'home',
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const HomeScreen();
          },
        ),
        GoRoute(
          name: 'photo',
          path: '/photo',
          builder: (BuildContext context, GoRouterState state) {
            return const PhotoScreen(bgColor: Colors.white);
          },
        ),
        GoRoute(
          name: 'routes',
          path: '/routes',
          builder: (BuildContext context, GoRouterState state) {
            return const RoutesScreen(bgColor: Colors.white);
          },
        ),
        GoRoute(
          name: 'map',
          path: '/map',
          builder: (BuildContext context, GoRouterState state) {
            return const MapScreen(title: "Mappa", bgColor: Colors.white);
          },
        ),
        GoRoute(
          name: 'settings',
          path: '/settings',
          builder: (BuildContext context, GoRouterState state) {
            return const SettingScreen(bgColor: Colors.white);
          },
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => const ErrorScreen(),
);

class AppVara extends StatelessWidget {
  const AppVara({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
      title: 'Base "Il Rostiolo"',
    );
  }
}
