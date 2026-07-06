# Testing

## Unit & widget tests

Run with:

```
flutter test
```

Every screen test should go through the `pumpApp` helper in `test/support/pump_app.dart`
instead of hand-rolling `pumpWidget(ProviderScope(child: MaterialApp(...)))` in each file. It
wraps the widget under test with the two things almost every screen needs — a `ProviderScope`
(with optional `overrides`) and a `TranslationProvider` — so tests don't repeat that
boilerplate and don't silently skip a provider the widget actually depends on:

```dart
await tester.pumpApp(
  const SettingsScreen(),
  overrides: [apiClientProvider.overrideWithValue(mockDio)],
);
```

### Mocking

[mocktail](https://pub.dev/packages/mocktail) is the template's mocking library (no code-gen
needed, works on any class since Dart classes are implicitly interfaces). Pattern used
throughout `test/`:

```dart
class _MockDio extends Mock implements Dio {}

when(() => dio.get<List<dynamic>>('/posts')).thenAnswer((_) async => Response(...));
```

See `test/features/posts/posts_screen_test.dart` for a full example covering both the
success and error paths of an `AsyncValue`-backed screen — note the error-path test needs
`pumpAndSettle()` rather than a single `pump()`, since the thrown exception has to propagate
through the `FutureProvider` before the widget rebuilds into its error state.

### What to test

Prioritize business logic and conditional rendering over pure-presentation widgets:

- Config/flag parsing (`AppConfig.fromEnv`, `FeatureFlags.fromEnv`, `validateEnv`) — pure
  functions, cheap to test exhaustively.
- Screens with conditional UI (a flag hides a section, an `AsyncValue` branches three ways).
- Anything with real logic (validators, the rename CLI's diff/plan builder).

Don't chase 100% coverage on widgets that are pure layout with no branching — the ROI is low
and they're the first thing to break on unrelated refactors.

## Integration / E2E tests

`integration_test/app_test.dart` is a Flutter-native `integration_test` smoke test (navigates
home → settings → back). Run against a real device/emulator:

```
flutter test integration_test/app_test.dart -d <device-id>
```

If the project later needs cross-platform, YAML-based E2E flows (rather than Dart-coded ones),
[Maestro](https://maestro.mobile.dev) works with Flutter apps the same way it works with React
Native — it drives the accessibility tree, not framework internals — and is a reasonable
alternative/addition to `integration_test` for that style of test.
