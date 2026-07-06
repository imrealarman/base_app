import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/app_config.dart';
import '../../../core/config/feature_flags.dart';
import '../../../core/router/route_paths.dart';
import '../../../i18n/strings.g.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flags = ref.watch(featureFlagsProvider);
    final config = ref.watch(appConfigProvider);
    final t = context.t;

    return FScaffold(
      header: FHeader(title: Text(t.app.title)),
      child: Center(
        child: FCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 10,
            children: [
              Text(t.home.environment(env: config.appEnv)),
              Text(t.home.apiBaseUrl(url: config.apiBaseUrl)),
              FButton(
                onPress: () => context.push(RoutePaths.settings),
                child: Text(t.home.openSettings),
              ),
              FButton(
                onPress: () => context.push(RoutePaths.posts),
                child: Text(t.home.openPosts),
              ),
              if (flags.analyticsEnabled) Text(t.home.analyticsOn),
            ],
          ),
        ),
      ),
    );
  }
}
