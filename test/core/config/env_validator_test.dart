import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:base_app/core/config/env_validator.dart';

void main() {
  group('validateEnv', () {
    test('does nothing when all required keys are present', () {
      dotenv.testLoad(
        fileInput: '''
APP_ENV=dev
API_BASE_URL=https://api.dev.example.com
APP_TEXT_DIRECTION=ltr
FEATURE_ANALYTICS_ENABLED=false
FEATURE_DARK_MODE_TOGGLE=true
FEATURE_SETTINGS_SCREEN=true
STRICT_ENV_VALIDATION=true
''',
      );

      expect(validateEnv, returnsNormally);
    });

    test('logs and continues when lenient and keys are missing', () {
      dotenv.testLoad(fileInput: 'STRICT_ENV_VALIDATION=false\n');

      expect(validateEnv, returnsNormally);
    });

    test('throws when strict and keys are missing', () {
      dotenv.testLoad(fileInput: 'STRICT_ENV_VALIDATION=true\n');

      expect(validateEnv, throwsA(isA<EnvValidationException>()));
    });
  });
}
