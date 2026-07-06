import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';

import '../../../core/config/feature_flags.dart';
import '../../../i18n/strings.g.dart';
import '../../../shared/widgets/section_label.dart';
import 'widgets/language_tile.dart';
import 'widgets/theme_mode_tile.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flags = ref.watch(featureFlagsProvider);
    final t = context.t;

    return FScaffold(
      header: FHeader(title: Text(t.settings.title)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionLabel(t.settings.displayNamePreview),
            FTextField(hint: t.settings.displayNameHint),
            if (flags.darkModeToggleEnabled) ...[
              SectionLabel(t.settings.theme),
              const ThemeModeTile(),
            ],
            SectionLabel(t.settings.language),
            const LanguageTile(),
          ],
        ),
      ),
    );
  }
}
