import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ravan/core/config/app_config.dart';

void main() {
  group('AppConfig.fromEnv', () {
    test('parses rtl direction', () {
      dotenv.testLoad(fileInput: 'APP_TEXT_DIRECTION=rtl\n');
      expect(AppConfig.fromEnv().textDirection, TextDirection.rtl);
    });

    test('defaults to ltr when missing', () {
      dotenv.testLoad(fileInput: '');
      expect(AppConfig.fromEnv().textDirection, TextDirection.ltr);
    });

    test('treats unrecognized values as ltr', () {
      dotenv.testLoad(fileInput: 'APP_TEXT_DIRECTION=sideways\n');
      expect(AppConfig.fromEnv().textDirection, TextDirection.ltr);
    });
  });
}
