import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ravan/core/config/feature_flags.dart';

void main() {
  group('FeatureFlags.fromEnv', () {
    test('reads true/false values from env', () {
      dotenv.testLoad(
        fileInput: '''
FEATURE_ANALYTICS_ENABLED=true
FEATURE_DARK_MODE_TOGGLE=false
FEATURE_SETTINGS_SCREEN=true
''',
      );

      final flags = FeatureFlags.fromEnv();

      expect(flags.analyticsEnabled, isTrue);
      expect(flags.darkModeToggleEnabled, isFalse);
      expect(flags.settingsScreenEnabled, isTrue);
    });

    test('falls back to defaults when keys are missing', () {
      dotenv.testLoad(fileInput: '');

      final flags = FeatureFlags.fromEnv();

      expect(flags.analyticsEnabled, isFalse);
      expect(flags.darkModeToggleEnabled, isTrue);
      expect(flags.settingsScreenEnabled, isTrue);
    });
  });
}
