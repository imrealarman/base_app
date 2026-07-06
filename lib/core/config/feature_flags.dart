import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feature_flags.g.dart';

class FeatureFlags {
  const FeatureFlags({
    required this.analyticsEnabled,
    required this.darkModeToggleEnabled,
    required this.settingsScreenEnabled,
  });

  final bool analyticsEnabled;
  final bool darkModeToggleEnabled;
  final bool settingsScreenEnabled;

  factory FeatureFlags.fromEnv() => FeatureFlags(
    analyticsEnabled: _boolFlag(
      'FEATURE_ANALYTICS_ENABLED',
      defaultValue: false,
    ),
    darkModeToggleEnabled: _boolFlag(
      'FEATURE_DARK_MODE_TOGGLE',
      defaultValue: true,
    ),
    settingsScreenEnabled: _boolFlag(
      'FEATURE_SETTINGS_SCREEN',
      defaultValue: true,
    ),
  );

  static bool _boolFlag(String key, {required bool defaultValue}) {
    final raw = dotenv.env[key];
    if (raw == null) return defaultValue;
    return raw.trim().toLowerCase() == 'true';
  }
}

@riverpod
FeatureFlags featureFlags(Ref ref) => FeatureFlags.fromEnv();
