final RegExp _bundleIdPattern = RegExp(
  r'^[a-z][a-z0-9_]*(\.[a-z][a-z0-9_]*)+$',
);

const _reservedWords = {
  'abstract',
  'as',
  'assert',
  'async',
  'await',
  'break',
  'case',
  'catch',
  'class',
  'const',
  'continue',
  'covariant',
  'default',
  'deferred',
  'do',
  'dynamic',
  'else',
  'enum',
  'export',
  'extends',
  'extension',
  'external',
  'factory',
  'false',
  'final',
  'finally',
  'for',
  'function',
  'get',
  'hide',
  'if',
  'implements',
  'import',
  'in',
  'interface',
  'is',
  'late',
  'library',
  'mixin',
  'new',
  'null',
  'on',
  'operator',
  'part',
  'required',
  'rethrow',
  'return',
  'set',
  'show',
  'static',
  'super',
  'switch',
  'sync',
  'this',
  'throw',
  'true',
  'try',
  'typedef',
  'var',
  'void',
  'while',
  'with',
  'yield',
  'package',
};

/// Validates a reverse-DNS bundle id (e.g. `com.company.appname`), used for both
/// the Android applicationId and the iOS bundle identifier, and to derive the
/// pubspec/Dart package name from its last segment.
String? validateBundleId(String input) {
  final value = input.trim();
  if (value.isEmpty) return 'Bundle id cannot be empty.';
  if (value != value.toLowerCase()) return 'Bundle id must be lowercase.';
  if (value.contains(' ')) return 'Bundle id must not contain spaces.';
  if (!_bundleIdPattern.hasMatch(value)) {
    return 'Bundle id must be reverse-DNS, e.g. com.company.appname '
        '(lowercase letters, digits, underscores; at least 2 segments; each segment starts with a letter).';
  }
  for (final segment in value.split('.')) {
    if (_reservedWords.contains(segment)) {
      return 'Bundle id segment "$segment" is a reserved keyword and cannot be used.';
    }
  }
  return null;
}

String? validateDisplayName(String input) {
  if (input.trim().isEmpty) return 'App display name cannot be empty.';
  return null;
}

String? validateTextDirection(String input) {
  final value = input.trim().toLowerCase();
  if (value != 'ltr' && value != 'rtl') {
    return 'Please enter "ltr" or "rtl".';
  }
  return null;
}
