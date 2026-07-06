import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/home/presentation/home_screen.dart';
import '../../features/posts/presentation/posts_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../config/feature_flags.dart';
import 'route_paths.dart';

part 'app_router.g.dart';

class _RouterRefreshNotifier extends ChangeNotifier {
  _RouterRefreshNotifier(Ref ref) {
    ref.listen(featureFlagsProvider, (_, _) => notifyListeners());
  }
}

@riverpod
GoRouter appRouter(Ref ref) {
  final refresh = _RouterRefreshNotifier(ref);
  ref.onDispose(refresh.dispose);

  return GoRouter(
    initialLocation: RoutePaths.home,
    refreshListenable: refresh,
    redirect: (context, state) {
      final flags = ref.read(featureFlagsProvider);
      if (state.matchedLocation == RoutePaths.settings &&
          !flags.settingsScreenEnabled) {
        return RoutePaths.home;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: RoutePaths.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: RoutePaths.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: RoutePaths.posts,
        builder: (context, state) => const PostsScreen(),
      ),
    ],
  );
}
