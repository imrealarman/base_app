<div align="center">

# 🧱 base_app

**A production-ready Flutter starter template — rename it, theme it, ship it.**

[![Flutter](https://img.shields.io/badge/Flutter-%3E%3D3.44.0-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-%5E3.12.2-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Riverpod](https://img.shields.io/badge/State-Riverpod-1B1B1F)](https://riverpod.dev)
[![forui](https://img.shields.io/badge/UI-forui-6D28D9)](https://forui.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](#license)

[Getting started](#-getting-started) •
[Features](#-features) •
[Docs](docs/README.md) •
[Architecture](#-architecture) •
[Libraries used](#-libraries-used)

</div>

---

## Philosophy

Most Flutter starters give you a folder structure and call it a day. **base_app** goes
further: it's opinionated about the things that are tedious to wire up correctly yourself —
per-environment config with validation, feature flags, RTL/LTR, i18n, theming, networking,
testing conventions, git hooks, and CI — so that on day one you're building your product, not
your toolchain.

Every convention here is designed to be **changed, not fought**: a font is one file to swap, an
app rename is one CLI command, a color scheme is a two-line diff. Read [`docs/`](docs/README.md)
for the how-to on every one of them.

## Is this template for you?

✅ You want feature-flagged, multi-environment (dev/staging/prod) builds without hand-rolling
config plumbing.
✅ You want RTL and i18n support from day one, not retrofitted later.
✅ You're comfortable with Riverpod and want its `AsyncValue`/caching model instead of a
separate data-fetching library.
✅ You want git hooks, CI, and testing conventions already decided so the team doesn't debate
them in every PR.

❌ You want a completely blank canvas with zero opinions — this template has plenty.
❌ You need `flutter_bloc`/`get_it`/`auto_route` — this template is Riverpod + go_router, and
mixing state-management paradigms tends to cause more friction than it saves.

## ✨ Features

| | |
|---|---|
| 🎨 **Theming** | [forui](https://forui.dev) design system with light/dark, swap swatches or override brand colors in one file |
| 🔤 **Configurable font** | Drop a `.ttf` into `lib/assets/fonts/app_font.ttf` — no code changes |
| 🌍 **i18n built-in** | Typed, code-generated translations via [slang](https://pub.dev/packages/slang) — English + Persian out of the box |
| ↔️ **RTL/LTR support** | One env var flips the whole app's layout direction |
| 🚦 **Feature flags** | Toggle features per environment via env vars — gates both UI and routing |
| 🌎 **3 environments** | dev/staging/prod, each with its own `.env` file and entrypoint |
| ✅ **Validated config** | Strict-in-CI, lenient-in-dev env validation catches misconfiguration before it ships |
| 🧠 **Riverpod** | Code-gen providers for config, flags, theme, router, and data — no boilerplate |
| 🌐 **Networking** | `dio` + Riverpod `FutureProvider`, with a full worked example feature |
| 🧭 **go_router** | Declarative routing with flag-gated redirects |
| 🏷️ **Rename CLI** | One interactive command renames the app, bundle id, and sets RTL/LTR — with diff preview, backup, and automatic rollback |
| 🖼️ **Icon & splash** | Generated from one source image via `flutter_launcher_icons` + `flutter_native_splash` |
| 🧪 **Testing conventions** | `pumpApp` test helper, `mocktail` mocking, widget + unit + integration tests |
| 🪝 **Git hooks** | `lefthook`-powered pre-commit format/analyze + Conventional Commits enforcement |
| 🔄 **CI included** | GitHub Actions: format, analyze, test, coverage |
| 🧩 **Feature-first architecture** | `core/` (cross-cutting) · `features/` (per-feature) · `shared/` (reusable) |

## 🚀 Getting started

```bash
# 1. Create your env files from the template
cp .env.example .env.dev
cp .env.example .env.staging
cp .env.example .env.prod

# 2. Install dependencies and generate code (Riverpod providers + i18n)
flutter pub get
dart run build_runner build --delete-conflicting-outputs

# 3. Run it
flutter run -t lib/main_dev.dart
```

> The `.env.*` files are gitignored — each developer creates their own from `.env.example`.
> Since they're declared as Flutter assets, the app won't build without them.

Then, before you ship:

```bash
# Rename the app, set its bundle id, and choose RTL/LTR — interactively, with a diff preview
dart run tool/cli/rename.dart

# Wire up git hooks (format/analyze on commit, Conventional Commits enforcement)
lefthook install
```

## 📁 Architecture

```
lib/
├── main.dart / main_dev.dart / main_staging.dart / main_prod.dart   # per-environment entrypoints
├── bootstrap.dart        # shared startup: env, i18n, locale restore
├── app.dart               # MaterialApp.router + theme + directionality
├── core/                  # cross-cutting concerns, no feature depends on another feature
│   ├── config/            #   env, feature flags, validation
│   ├── network/           #   shared dio client
│   ├── theme/              #   forui theme + font
│   ├── router/             #   go_router setup
│   └── i18n/               #   locale persistence
├── features/               # one folder per feature — the unit of ownership
│   ├── home/
│   ├── settings/
│   └── posts/              #   worked example: dio + Riverpod FutureProvider
├── shared/                 # widgets/models reused across features
└── i18n/                    # translation source files + generated typed strings

test/
├── support/pump_app.dart    # shared test harness (ProviderScope + TranslationProvider)
├── core/                    # unit tests for config/flags/validation
└── features/                # widget tests mirroring lib/features/

tool/cli/                    # the interactive rename CLI + commit-msg checker
docs/                        # one guide per customization topic — start at docs/README.md
```

See [docs/README.md](docs/README.md) for the full guide index, or jump straight to a topic:
[theming](docs/theming.md) · [fonts](docs/fonts.md) · [icons & splash](docs/icons-and-splash.md) ·
[renaming](docs/renaming.md) · [environments](docs/environments.md) · [i18n](docs/i18n.md) ·
[networking](docs/networking.md) · [testing](docs/testing.md) · [git hooks & CI](docs/git-hooks-and-ci.md).

## Adding a new feature module

Mirror the structure of `lib/features/posts` (if it talks to an API) or
`lib/features/settings` (if it's pure UI):

1. Create `lib/features/<name>/presentation/<name>_screen.dart` (and `data/` if it fetches data).
2. Add a path constant to `lib/core/router/route_paths.dart`.
3. Register a `GoRoute` for it in `lib/core/router/app_router.dart`.
4. Add translation keys to `lib/i18n/en.i18n.json` and `fa.i18n.json`.
5. Add a widget test under `test/features/<name>/` using the `pumpApp` helper.

## 📦 Libraries used

- [forui](https://forui.dev) — UI component & theming system
- [flutter_riverpod](https://riverpod.dev) + `riverpod_generator` — state management & DI
- [go_router](https://pub.dev/packages/go_router) — declarative routing
- [flutter_dotenv](https://pub.dev/packages/flutter_dotenv) — per-environment config
- [dio](https://pub.dev/packages/dio) — HTTP client
- [slang](https://pub.dev/packages/slang) + `slang_flutter` — typed, code-generated i18n
- [shared_preferences](https://pub.dev/packages/shared_preferences) — locale persistence
- [mocktail](https://pub.dev/packages/mocktail) — test mocking
- [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) + [flutter_native_splash](https://pub.dev/packages/flutter_native_splash) — icon/splash generation
- [lefthook](https://github.com/evilmartians/lefthook) — git hooks

## Testing

```bash
flutter test
flutter test integration_test/app_test.dart -d <device-id>
```

See [docs/testing.md](docs/testing.md) for the `pumpApp` helper and mocking conventions.

## Contributing

This is a template — fork it, rename it (see above), and make it yours. If you find a bug in
the template itself or have an improvement that would benefit anyone starting from it, issues
and PRs are welcome.

## License

MIT — use this template for anything, no attribution required.
