import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart' show Bidi;

import 'core/config/environment.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_mode_provider.dart';
import 'i18n/strings.g.dart';

class App extends ConsumerWidget {
  const App({super.key, required this.environment});

  final Environment environment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeModeProvider);
    final locale = TranslationProvider.of(context).flutterLocale;
    final textDirection = Bidi.isRtlLanguage(locale.languageCode)
        ? TextDirection.rtl
        : TextDirection.ltr;

    final brightness = switch (themeMode) {
      ThemeMode.light => Brightness.light,
      ThemeMode.dark => Brightness.dark,
      ThemeMode.system => MediaQuery.platformBrightnessOf(context),
    };
    final fTheme = resolveFTheme(brightness: brightness);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: const [
        ...FLocalizations.localizationsDelegates,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: fTheme.toApproximateMaterialTheme(),
      builder: (context, child) => Directionality(
        textDirection: textDirection,
        child: FTheme(
          data: fTheme,
          child: FToaster(child: FTooltipGroup(child: child!)),
        ),
      ),
    );
  }
}
