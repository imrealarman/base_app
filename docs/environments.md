# Environments & feature flags

## Environments

There are three environments — `dev`, `staging`, `prod` — each backed by its own env file
(`.env.dev`, `.env.staging`, `.env.prod`) and entrypoint (`lib/main_dev.dart`,
`lib/main_staging.dart`, `lib/main_prod.dart`):

```
flutter run -t lib/main_dev.dart
flutter run -t lib/main_staging.dart
flutter run -t lib/main_prod.dart
```

The `.env.*` files are gitignored — copy `.env.example` to create your own on first checkout
(see the main [README.md](../README.md)). `lib/main.dart` defaults to `dev`, for tooling that
always launches it directly (e.g. an IDE's default "Run" button).

An entrypoint's environment can be overridden at build/run time without touching code:

```
flutter run -t lib/main_dev.dart --dart-define=ENVIRONMENT=prod
```

## Env vars in this template

| Key | Read by | Purpose |
|---|---|---|
| `APP_ENV` | `AppConfig.appEnv` | Free-form label, shown on the home screen |
| `API_BASE_URL` | `AppConfig.apiBaseUrl` | Backend base URL |
| `APP_TEXT_DIRECTION` | `AppConfig.textDirection` | `ltr` or `rtl` — see [renaming.md](renaming.md) |
| `FEATURE_ANALYTICS_ENABLED` | `FeatureFlags.analyticsEnabled` | Shows/hides the analytics line on the home screen |
| `FEATURE_DARK_MODE_TOGGLE` | `FeatureFlags.darkModeToggleEnabled` | Shows/hides the theme picker on the settings screen |
| `FEATURE_SETTINGS_SCREEN` | `FeatureFlags.settingsScreenEnabled` | Enables the `/settings` route; disabling it redirects there via `go_router` |

Flip any value and relaunch — flags are read once at startup (`dotenv.load()` in
`bootstrap.dart`), no code changes or `build_runner` re-run required.

## Strict validation

`STRICT_ENV_VALIDATION` (`true`/`false`) controls what happens if a required key (see
`lib/core/config/env_validator.dart`) is missing after `dotenv.load()`:

- `false` (the default in `.env.dev`) — logs a warning and continues, so local dev isn't
  blocked by an incomplete `.env` file.
- `true` (the default in `.env.staging`/`.env.prod`, and forced in CI) — throws
  `EnvValidationException`, failing the build loudly instead of silently falling back.

## Adding a new feature flag

1. Add the key to all four env files (`.env.example` + the three real `.env.*` files) with a
   sensible default.
2. Add a field to `FeatureFlags` in `lib/core/config/feature_flags.dart` and read it in
   `FeatureFlags.fromEnv()` using the existing `_boolFlag` helper.
3. Read it wherever needed via `ref.watch(featureFlagsProvider)`.

## Adding a new config value (not a boolean flag)

Follow the same pattern in `lib/core/config/app_config.dart`: add a field to `AppConfig`, read
it from `dotenv.env[...]` in `AppConfig.fromEnv()` with a fallback default.
