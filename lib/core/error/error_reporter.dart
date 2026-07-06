import 'package:flutter/foundation.dart';

import '../logging/app_logger.dart';

/// Central hook for uncaught errors. `bootstrap()` wires [install] to catch
/// Flutter framework errors and platform errors, and passes [reportError]
/// itself as the handler for errors escaping `runZonedGuarded` — so every
/// uncaught error in the app already flows through this one function.
///
/// By default this only logs. Forward to a real crash reporter (Sentry,
/// Firebase Crashlytics, etc.) by adding the call in [reportError] once
/// you've picked one.
class ErrorReporter {
  const ErrorReporter();

  static const _logger = AppLogger('ErrorReporter');

  void install() {
    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      reportError(details.exception, details.stack ?? StackTrace.empty);
    };

    PlatformDispatcher.instance.onError = (error, stackTrace) {
      reportError(error, stackTrace);
      return true;
    };
  }

  void reportError(Object error, StackTrace stackTrace) {
    _logger.error('Uncaught error', error, stackTrace);
  }
}
