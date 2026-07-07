# Code generation (build_runner)

This template uses `build_runner` for two things:

- **[riverpod_generator](https://pub.dev/packages/riverpod_generator)** — turns a `@riverpod`
  annotated function/class into a typed provider. Source files, each with a matching
  `part 'x.g.dart';`:
  - `lib/core/config/app_config.dart`
  - `lib/core/config/feature_flags.dart`
  - `lib/core/network/api_client.dart`
  - `lib/core/router/app_router.dart`
  - `lib/core/theme/theme_mode_provider.dart`
  - `lib/features/posts/data/posts_api.dart`
- **[slang](https://pub.dev/packages/slang)** — turns `lib/i18n/*.i18n.json` into the typed
  `Translations` class (`lib/i18n/strings.g.dart` + one file per locale). See
  [i18n.md](i18n.md).

All of it lands in `*.g.dart` files.

## The `*.g.dart` files are gitignored — don't commit them

They used to be committed. That's exactly what caused the pain of pulling this template into
multiple repos: two clones (or two branches) each regenerate the same `*.g.dart` file
independently, producing byte-for-byte different but semantically equivalent output. Git can't
merge that — it just sees two versions of a machine-written file and conflicts, and there's no
sane way to hand-resolve a conflict inside generated code.

The fix is to never version them at all:

- `.gitignore` excludes `*.g.dart` everywhere in the repo.
- CI (`.github/workflows/ci.yml`) regenerates from scratch on every run — it never relied on
  committed output.
- `lefthook.yml`'s `post-merge` and `post-checkout` hooks regenerate automatically after a
  pull/merge/branch switch, so your working tree doesn't go stale (requires `lefthook install`
  once per clone — see [git-hooks-and-ci.md](git-hooks-and-ci.md)).

If you're pulling this template into an already-existing repo that still has `*.g.dart` files
committed from before this change, remove them from tracking once:

```
git rm --cached $(git ls-files '*.g.dart')
```

They'll stay on disk (regenerate them immediately after) but Git will stop diffing/merging them.

## When you must run build_runner yourself

The git hooks cover pulls and branch switches automatically. You still need to run it by hand
after:

- Editing any `@riverpod`-annotated file (the six listed above), or adding a new one.
- Adding/editing a `lib/i18n/*.i18n.json` translation file, or adding a new locale.
- Editing `build.yaml`.
- Cloning the repo for the first time (README's "Getting started" step 2).

Command:

```
dart run build_runner build --delete-conflicting-outputs
```

If you're actively iterating on providers or translations, run it in watch mode instead so it
regenerates on every save:

```
dart run build_runner watch --delete-conflicting-outputs
```

## Signs you forgot to regenerate

- Analyzer/IDE error: `Target of URI hasn't been generated: 'x.g.dart'.`
- Undefined name for a generated provider (e.g. `appConfigProvider`) or for `AppLocale`/`t`.
- `flutter analyze` or `flutter test` fails on a file that otherwise looks correct.

## Troubleshooting

`InvalidOutputException: Asset already exists` — a stale `*.g.dart` on disk doesn't match
`.dart_tool`'s build cache (common after switching branches with very different generated
output, or restoring an old `.dart_tool` from somewhere). Fix once with:

```
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs
```
