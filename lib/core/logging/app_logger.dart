import 'dart:developer' as developer;

/// Thin wrapper around `dart:developer`'s `log()` — shows up in DevTools and
/// IDE consoles with named log sources, without pulling a third-party
/// logging package into the template. Swap the implementation here (e.g. for
/// `package:logger`) if you need richer formatting; call sites elsewhere in
/// the app don't change.
class AppLogger {
  const AppLogger(this._name);

  final String _name;

  void debug(String message) => _log(message, level: 500);

  void info(String message) => _log(message, level: 800);

  void warning(String message) => _log(message, level: 900);

  void error(String message, [Object? error, StackTrace? stackTrace]) =>
      _log(message, level: 1000, error: error, stackTrace: stackTrace);

  void _log(
    String message, {
    required int level,
    Object? error,
    StackTrace? stackTrace,
  }) {
    developer.log(
      message,
      name: _name,
      level: level,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
