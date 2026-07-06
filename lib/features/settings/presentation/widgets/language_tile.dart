import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

import '../../../../core/i18n/locale_storage.dart';
import '../../../../i18n/strings.g.dart';

const _languageLabels = {AppLocale.en: 'English', AppLocale.fa: 'فارسی'};

/// Lets the user override the device locale; the choice is persisted via
/// [LocaleStorage] so it's restored on the next launch.
class LanguageTile extends StatelessWidget {
  const LanguageTile({super.key});

  @override
  Widget build(BuildContext context) {
    final current = TranslationProvider.of(context).locale;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final locale in AppLocale.values)
          FRadio(
            label: Text(_languageLabels[locale] ?? locale.languageTag),
            value: current == locale,
            onChange: (selected) async {
              if (!selected) return;
              await LocaleSettings.setLocale(locale);
              await const LocaleStorage().write(locale.name);
            },
          ),
      ],
    );
  }
}
