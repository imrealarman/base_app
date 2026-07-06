# Renaming, package id, and text direction

Before shipping, run the interactive CLI once to move the app off its `base_app` /
`com.example.base_app` placeholders and set its text direction:

```
dart run tool/cli/rename.dart
```

## What it asks

| Prompt | Example | What it changes |
|---|---|---|
| New app display name | `Demo App` | Android `android:label`, iOS `CFBundleDisplayName` |
| New package/bundle id | `com.acme.demoapp` | Android `applicationId`/`namespace`, iOS `PRODUCT_BUNDLE_IDENTIFIER`, `pubspec.yaml` `name:`, all `package:base_app/...` imports, `MainActivity`'s package + folder location |
| New app description | `A demo application.` | `pubspec.yaml` `description:` |
| Text direction (`ltr`/`rtl`) | `rtl` | `APP_TEXT_DIRECTION` in every `.env.*` file that exists locally |

The package/bundle id's **last segment** becomes the new Dart package name (e.g.
`com.acme.demoapp` → package name `demoapp`), so pick a bundle id whose last segment is a
valid Dart identifier (lowercase letters, digits, underscores, starting with a letter).

## What happens when you confirm

1. A full diff of every file the tool is about to touch is printed first — nothing is written
   until you type `y`.
2. Every touched file is backed up to `.rename_backup/<timestamp>/` before any change is
   applied.
3. If anything fails partway through, already-applied changes are automatically rolled back
   from that backup and the tool exits non-zero.
4. It's safe to re-run: if the project already matches what you typed, it prints
   "No changes needed" and exits without touching anything.

After it finishes, run `flutter pub get` and `flutter analyze` to confirm the rename didn't
break anything.

## Text direction (RTL/LTR)

`APP_TEXT_DIRECTION` is read by `lib/core/config/app_config.dart` at startup and applied in
`lib/app.dart` via a `Directionality` widget wrapping the whole app — so every layout
(`Row`, `Column`, `Text.textAlign`, form fields, etc.) mirrors automatically for RTL languages
like Arabic, Persian, or Hebrew, with no per-widget changes needed.

To change it without re-running the whole rename flow, edit `APP_TEXT_DIRECTION` directly in
the relevant `.env.<environment>` file (`ltr` or `rtl`) and relaunch — see
[environments.md](environments.md).
