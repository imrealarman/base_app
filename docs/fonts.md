# Fonts

The app uses a single font family, declared once in `pubspec.yaml` and applied everywhere
(forui widgets and Material widgets alike) via `lib/core/theme/app_theme.dart`.

## Changing the font

1. Get your `.ttf` file.
2. Rename it to exactly `app_font.ttf`.
3. Replace `lib/assets/fonts/app_font.ttf` with it.
4. Run `flutter pub get` (only needed if you're changing the file for the first time in a
   fresh checkout) and restart the app.

No code or `pubspec.yaml` changes are required — the filename is the contract. This template
ships with [IRANYekanX](https://fontiran.com) (`app_font.ttf`) as the default, a variable font
that reads well in both Persian/Arabic (RTL) and Latin (LTR) scripts — see
[renaming.md](renaming.md) for setting text direction.

## How it's wired up

`pubspec.yaml` declares one font family:

```yaml
flutter:
  fonts:
    - family: AppFont
      fonts:
        - asset: lib/assets/fonts/app_font.ttf
```

`lib/core/theme/app_fonts.dart` exposes that family name as `appFontFamily`, and
`lib/core/theme/app_theme.dart` builds the forui typography with it:

```dart
final typeface = FTypeface.inherit(colors: colors, touch: isTouch, fontFamily: appFontFamily);
final typography = FTypography(display: typeface, body: typeface);
```

That `typography` feeds both `FThemeData` (used by all forui widgets) and
`toApproximateMaterialTheme()` (used by any plain Material widgets), so there's exactly one
font to change.

## Adding weight variants (bold, italic, etc.)

If your font ships as separate files per weight (rather than a single variable font like the
default), declare each one under the same family with its `weight`/`style`:

```yaml
flutter:
  fonts:
    - family: AppFont
      fonts:
        - asset: lib/assets/fonts/app_font.ttf
        - asset: lib/assets/fonts/app_font_bold.ttf
          weight: 700
        - asset: lib/assets/fonts/app_font_italic.ttf
          style: italic
```

Every file referenced in `pubspec.yaml` must exist, or `flutter pub get`/`flutter run` will
fail with a missing-asset error.

## Adding a second font family

Only need a custom font for headings, or a monospace font for code? Declare an additional
`family:` entry in `pubspec.yaml`, then reference it by name directly in a `TextStyle`
(`TextStyle(fontFamily: 'YourOtherFamily')`) wherever you need it, instead of changing the
app-wide `appFontFamily`.
