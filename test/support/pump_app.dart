import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';

import 'package:base_app/i18n/strings.g.dart';

/// Pumps [widget] wrapped with the providers every screen expects in
/// production: a [ProviderScope] (optionally pre-seeded via [overrides]) and
/// a [TranslationProvider] so `context.t` resolves in widget tests without
/// each test file repeating the boilerplate.
extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    List<Override> overrides = const [],
    AppLocale locale = AppLocale.en,
  }) async {
    LocaleSettings.setLocaleSync(locale);
    await pumpWidget(
      ProviderScope(
        overrides: overrides,
        child: TranslationProvider(child: MaterialApp(home: widget)),
      ),
    );
  }
}
