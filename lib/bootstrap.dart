import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/config/env_validator.dart';
import 'core/config/environment.dart';
import 'core/i18n/locale_storage.dart';
import 'i18n/strings.g.dart';

Future<void> bootstrap(Environment env) async {
  WidgetsFlutterBinding.ensureInitialized();

  final resolvedEnv = Environment.values.firstWhere(
    (e) =>
        e.name == const String.fromEnvironment('ENVIRONMENT', defaultValue: ''),
    orElse: () => env,
  );

  await dotenv.load(fileName: resolvedEnv.envFileName);
  validateEnv();

  final savedLocale = await const LocaleStorage().read();
  if (savedLocale != null) {
    // Must be the async setter: `fa`'s translations are deferred-loaded
    // (see lib/i18n/strings.g.dart), and setLocaleSync's buildSync() path
    // never awaits the deferred library, crashing before runApp() is
    // reached — which shows up as the app being stuck on the native splash
    // screen followed by a crash.
    await LocaleSettings.setLocale(AppLocaleUtils.parse(savedLocale));
  } else {
    await LocaleSettings.useDeviceLocale();
  }

  runApp(
    ProviderScope(
      child: TranslationProvider(child: App(environment: resolvedEnv)),
    ),
  );
}
