import 'package:Bloomee/core/constants/route_paths.dart';
import 'package:Bloomee/screens/widgets/global_footer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:Bloomee/screens/screen/common_views/add_to_playlist_screen.dart';
import 'package:Bloomee/screens/screen/explore_screen.dart';
import 'package:Bloomee/screens/screen/library_screen.dart';
import 'package:Bloomee/screens/screen/library_views/import_media_view.dart';
import 'package:Bloomee/screens/screen/library_views/import_process_screen.dart';
import 'package:Bloomee/screens/screen/library_views/playlist_screen.dart';
import 'package:Bloomee/screens/screen/offline_screen.dart';
import 'package:Bloomee/screens/screen/local_music_screen.dart';
import 'package:Bloomee/screens/screen/search_screen.dart';
import 'package:Bloomee/screens/screen/chart/chart_view.dart';

/// Canonical app router configuration.
///
/// Use [AppRouter] in new code. The [GlobalRoutes] typedef at the bottom
/// provides backward-compatible access for existing callers.
class AppRouter {
  static final globalRouterKey = GlobalKey<NavigatorState>();
  static const String _defaultLocation = '/Explore';
  static const List<String> _restorableRoots = [
    '/Explore',
    '/Library',
    '/Search',
    '/LocalMusic',
    '/Offline',
  ];
  static String _initialLocation = _defaultLocation;
  static GoRouter? _globalRouter;

  static void configureInitialLocation(String? location) {
    if (_globalRouter != null) return;
    _initialLocation = normalizeRestorableLocation(location);
  }

  static String normalizeRestorableLocation(String? location) {
    if (location == null || location.isEmpty) return _defaultLocation;
    final uri = Uri.tryParse(location);
    if (uri == null || !isRestorableLocation(uri.toString())) {
      return _defaultLocation;
    }
    return uri.toString();
  }

  static bool isRestorableLocation(String? location) {
    if (location == null || location.isEmpty) return false;
    final uri = Uri.tryParse(location);
    if (uri == null) return false;
    final path = uri.path;
    return _restorableRoots
        .any((root) => path == root || path.startsWith('$root/'));
  }

  static GoRouter get globalRouter => _globalRouter ??= GoRouter(
    initialLocation: _initialLocation,
    navigatorKey: globalRouterKey,
    routes: [
      GoRoute(
        path: '/AddToPlaylist',
        parentNavigatorKey: globalRouterKey,
        name: RoutePaths.addToPlaylistScreen,
        builder: (context, state) => const AddToPlaylistScreen(),
      ),
      StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) =>
              GlobalFooter(navigationShell: navigationShell),
          branches: [
            StatefulShellBranch(routes: [
              GoRoute(
                  name: RoutePaths.exploreScreen,
                  path: '/Explore',
                  builder: (context, state) => const ExploreScreen(),
                  routes: [
                    GoRoute(
                        name: RoutePaths.chartScreen,
                        path: 'ChartScreen',
                        builder: (context, state) {
                          final qp = state.uri.queryParameters;
                          return ChartScreen(
                            pluginId: qp['pluginId'] ?? '',
                            chartId: qp['chartId'] ?? '',
                            chartTitle: qp['chartTitle'] ?? 'Chart',
                          );
                        }),
                  ])
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                  name: RoutePaths.libraryScreen,
                  path: '/Library',
                  builder: (context, state) => const LibraryScreen(),
                  routes: [
                    GoRoute(
                      path: RoutePaths.importMediaFromPlatforms,
                      name: RoutePaths.importMediaFromPlatforms,
                      builder: (context, state) =>
                          const ImportMediaFromPlatformsView(),
                    ),
                    GoRoute(
                      path: RoutePaths.importProcess,
                      name: RoutePaths.importProcess,
                      builder: (context, state) {
                        final pluginId =
                            state.uri.queryParameters['pluginId'] ?? '';
                        return ImportProcessScreen(pluginId: pluginId);
                      },
                    ),
                    GoRoute(
                      name: RoutePaths.playlistView,
                      path: RoutePaths.playlistView,
                      builder: (context, state) {
                        final initialPlaylistName = state.extra as String?;
                        return PlaylistView(
                          initialPlaylistName: initialPlaylistName,
                        );
                      },
                    ),
                  ]),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                name: RoutePaths.searchScreen,
                path: '/Search',
                builder: (context, state) {
                  if (state.uri.queryParameters['query'] != null) {
                    return SearchScreen(
                      searchQuery:
                          state.uri.queryParameters['query']!.toString(),
                    );
                  } else {
                    return const SearchScreen();
                  }
                },
              ),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                name: RoutePaths.localMusicScreen,
                path: '/LocalMusic',
                builder: (context, state) => const LocalMusicScreen(),
              ),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                name: RoutePaths.offlineScreen,
                path: '/Offline',
                builder: (context, state) => const OfflineScreen(),
              ),
            ]),
          ])
    ],
  );
}

/// Backward-compat alias for [AppRouter].
/// Prefer importing from [routes/app_router.dart] and using [AppRouter] directly.
typedef GlobalRoutes = AppRouter;
