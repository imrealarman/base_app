# Error handling & logging

## Uncaught errors

`bootstrap.dart` wires `ErrorReporter` (`lib/core/error/error_reporter.dart`) so no uncaught
error in the app is silently dropped:

- `FlutterError.onError` — errors thrown during the widget build/layout/paint pipeline.
- `PlatformDispatcher.instance.onError` — errors from the platform/engine (e.g. a failed
  platform channel call).
- `runZonedGuarded` around the whole `bootstrap()` body — anything that escapes the two hooks
  above (e.g. an error thrown in a `Future` or `Timer` callback not awaited by a widget).

All three funnel into `ErrorReporter.reportError`, which by default just logs via `AppLogger`.
Wire your crash reporter of choice (Sentry, Firebase Crashlytics, etc.) by adding the call
inside `reportError` — every uncaught error already flows through that one function, so there's
exactly one place to change.

## Expected failures vs. bugs

Don't route expected failure modes (a 404, no internet, a validation error) through
`ErrorReporter` — those are normal control flow a screen should handle directly. See
[networking.md](networking.md#error-handling) for `ApiException`, the pattern for turning a
caught `DioException` into a specific, user-facing message. Reserve `ErrorReporter` for things
that indicate an actual bug.

## Logging

`lib/core/logging/app_logger.dart` wraps `dart:developer`'s `log()` — visible in DevTools and
IDE consoles with a named source, no third-party package required:

```dart
class _Logger {
  static const _log = AppLogger('MyFeature');
}

_log.info('Fetched ${items.length} items');
_log.error('Failed to sync', error, stackTrace);
```

If you need richer formatting (colors, JSON output, remote log shipping), swap the
implementation inside `AppLogger` for `package:logger` or similar — call sites elsewhere in the
app don't change.
