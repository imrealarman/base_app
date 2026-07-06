import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';

import '../../../../core/theme/theme_mode_provider.dart';
import '../../../../i18n/strings.g.dart';

class ThemeModeTile extends ConsumerWidget {
  const ThemeModeTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeModeProvider);
    final notifier = ref.read(themeModeProvider.notifier);
    final t = context.t;

    final labels = {
      ThemeMode.system: t.settings.themeMode.system,
      ThemeMode.light: t.settings.themeMode.light,
      ThemeMode.dark: t.settings.themeMode.dark,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final option in ThemeMode.values)
          FRadio(
            label: Text(labels[option]!),
            value: mode == option,
            onChange: (selected) {
              if (selected) notifier.set(option);
            },
          ),
      ],
    );
  }
}
