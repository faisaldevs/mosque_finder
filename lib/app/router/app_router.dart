import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mosque_finder_app/app/di/di.dart';
import 'package:mosque_finder_app/app/router/config/navigation_service.dart';
import 'package:mosque_finder_app/app/router/config/route_names.dart';
import 'package:mosque_finder_app/app/router/routes/auth_route.dart';
import 'package:mosque_finder_app/app/router/routes/home_route.dart';
import 'package:mosque_finder_app/app/router/routes/mosque_route.dart';
import 'package:mosque_finder_app/app/router/routes/profile_route.dart';
import 'package:mosque_finder_app/feature/bottom_navigation_screen.dart';
import 'package:mosque_finder_app/feature/feed/presentation/view/feed_screen.dart';
import 'package:mosque_finder_app/feature/home/presentation/view/home_screen.dart';
import 'package:mosque_finder_app/feature/mosques/screens/mosques_finder_screen.dart';
import 'package:mosque_finder_app/feature/profile/view/profile_screen.dart';
import 'package:mosque_finder_app/start/loading_screen.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class AppRouter {
  static late final GoRouter _router;

  static void setupRouter() {
    final navService = locator<NavigationService>();

    _router = GoRouter(
      initialLocation: RouteNames.initialLoading,
      observers: [routeObserver],
      routes: [
        ///===================================================
        ///===================================================
        /// ************ Initial Routes ************
        ///===================================================
        ///===================================================
        GoRoute(
          path: RouteNames.initialLoading,
          builder: (_, __) => const Loading(),
        ),

        ///===================================================
        ///===================================================
        /// ************ Bottom navigation shell ************
        ///===================================================
        ///===================================================
        _mainNavigationShell(),

        ///===================================================
        ///===================================================
        /// ************ Feature-specific routes ************
        ///===================================================
        ///===================================================
        ...AuthRouter.routes,
        ...HomeRouter.routes,
        ...ProfileRouter.routes,
        ...MosqueRouter.routes,
      ],

      // Redirect unauthenticated users
      // redirect: (context, state) {
      //   final isLoggedIn = locator<AuthService>().isLoggedIn;
      //   final loggingIn = state.subloc == '/login';
      //   if (!isLoggedIn && !loggingIn) return '/login';
      //   if (isLoggedIn && loggingIn) return '/home';
      //   return null;
      // },
      errorBuilder: (_, state) =>
          Scaffold(body: Center(child: Text('Page not found: ${state.error}'))),
    );

    navService.setRouter(_router);
  }

  static GoRouter get router => _router;

  static StatefulShellRoute _mainNavigationShell() {
    return StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          BottomNavigationScreen(shell: navigationShell),
      branches: [
        _buildBranch(RouteNames.home, const HomeScreen()),
        _buildBranch(RouteNames.feed, const FeedScreen()),
        _buildBranch(RouteNames.mosque, const MosquesFinderScreen()),

        // _buildBranch(RouteNames.ranking, const HomeScreen()),
        _buildBranch(RouteNames.profile, const ProfileScreen()),
      ],
    );
  }

  static StatefulShellBranch _buildBranch(String path, Widget screen) {
    return StatefulShellBranch(
      routes: [GoRoute(path: path, builder: (_, __) => screen)],
    );
  }
}
