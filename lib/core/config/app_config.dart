import 'package:flutter/rendering.dart' show TextDirection;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_config.g.dart';

class AppConfig {
  const AppConfig({
    required this.appEnv,
    required this.apiBaseUrl,
    required this.textDirection,
  });

  final String appEnv;
  final String apiBaseUrl;

  /// Set via the `APP_TEXT_DIRECTION` env var (`ltr` or `rtl`, defaults to `ltr`).
  /// Change it interactively with `dart run tool/cli/rename.dart`, or edit the
  /// `.env.*` files directly. See `docs/renaming.md`.
  ///
  /// Not applied directly to the widget tree: `lib/app.dart` derives the
  /// actual `Directionality` from the active locale (so switching languages
  /// at runtime updates it), falling back to this value only makes sense if
  /// you bypass locale-based resolution entirely.
  final TextDirection textDirection;

  factory AppConfig.fromEnv() => AppConfig(
    appEnv: dotenv.env['APP_ENV'] ?? 'dev',
    apiBaseUrl: dotenv.env['API_BASE_URL'] ?? 'https://api.dev.example.com',
    textDirection: _parseTextDirection(dotenv.env['APP_TEXT_DIRECTION']),
  );

  static TextDirection _parseTextDirection(String? raw) =>
      raw?.trim().toLowerCase() == 'rtl'
      ? TextDirection.rtl
      : TextDirection.ltr;
}

@riverpod
AppConfig appConfig(Ref ref) => AppConfig.fromEnv();
