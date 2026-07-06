import 'dart:developer' as developer;

import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Keys every environment file must define. Kept separate from the defaults
/// in [AppConfig]/[FeatureFlags] on purpose: those defaults let local dev keep
/// moving with an incomplete `.env`, while this list is what CI enforces via
/// `STRICT_ENV_VALIDATION=true` so a missing/misconfigured `.env.*` fails the
/// build instead of silently falling back in a shipped environment.
const requiredEnvKeys = [
  'APP_ENV',
  'API_BASE_URL',
  'APP_TEXT_DIRECTION',
  'FEATURE_ANALYTICS_ENABLED',
  'FEATURE_DARK_MODE_TOGGLE',
  'FEATURE_SETTINGS_SCREEN',
];

/// Thrown when strict validation is on and one or more [requiredEnvKeys] are
/// missing from the loaded env file.
class EnvValidationException implements Exception {
  const EnvValidationException(this.missingKeys);

  final List<String> missingKeys;

  @override
  String toString() =>
      'EnvValidationException: missing required env keys: ${missingKeys.join(', ')}';
}

/// Validates that [requiredEnvKeys] are present in the currently loaded
/// `.env.*` file (call after `dotenv.load()`).
///
/// Strict mode is controlled by the `STRICT_ENV_VALIDATION` env var (or a
/// `--dart-define=STRICT_ENV_VALIDATION=true` override for CI, which takes
/// priority since dart-define is set at build/CI time and can't be edited
/// per-.env-file the way a local key can):
/// - `true`: throws [EnvValidationException] on any missing key (use in CI).
/// - otherwise: logs a warning and continues, so local dev isn't blocked by
///   an incomplete `.env` file.
void validateEnv() {
  final missingKeys = requiredEnvKeys
      .where((key) => dotenv.env[key] == null)
      .toList();
  if (missingKeys.isEmpty) return;

  if (_strictValidation) {
    throw EnvValidationException(missingKeys);
  }

  developer.log(
    'Missing env keys (continuing because STRICT_ENV_VALIDATION is off): ${missingKeys.join(', ')}',
    name: 'env_validator',
    level: 900,
  );
}

bool get _strictValidation {
  const dartDefine = String.fromEnvironment('STRICT_ENV_VALIDATION');
  if (dartDefine.isNotEmpty) return dartDefine.toLowerCase() == 'true';
  return dotenv.env['STRICT_ENV_VALIDATION']?.trim().toLowerCase() == 'true';
}
