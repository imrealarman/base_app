# Theming

The app's visual theme is built in one place: `lib/core/theme/app_theme.dart`. Its
`resolveFTheme()` function is called from `lib/app.dart` every time brightness (light/dark)
changes, and returns a forui `FThemeData` that also drives the approximated Material theme
via `fTheme.toApproximateMaterialTheme()`. You don't need to touch `app.dart` for either of
the changes below.

## Switching to a different built-in color swatch

forui ships several ready-made swatches, each with light and dark variants:
`zinc` (default), `slate`, `neutral`, `blue`, `green`, `orange`, `red`, `rose`, `violet`, `yellow`.

Open `lib/core/theme/app_theme.dart` and change the two `FColors` references:

```dart
// Before
final colors = brightness == Brightness.dark ? FColors.zincDark : FColors.zincLight;

// After — switch to the "violet" swatch
final colors = brightness == Brightness.dark ? FColors.violetDark : FColors.violetLight;
```

That's it — every forui widget (`FButton`, `FCard`, `FTextField`, ...) and the Material
`ThemeData` derived from it will pick up the new palette immediately.

## Defining your own brand colors

If none of the built-in swatches match your brand, start from the closest one and override
individual colors with `copyWith`:

```dart
final colors = (brightness == Brightness.dark ? FColors.zincDark : FColors.zincLight).copyWith(
  primary: const Color(0xFF6D28D9),
  primaryForeground: const Color(0xFFFFFFFF),
  // secondary, muted, destructive, border, etc. can all be overridden the same way.
);
```

Each `FColors` swatch defines: `background`, `foreground`, `primary`, `primaryForeground`,
`secondary`, `secondaryForeground`, `muted`, `mutedForeground`, `destructive`,
`destructiveForeground`, `error`, `errorForeground`, `card`, `border`, plus `brightness` and
`systemOverlayStyle`. Override only the ones your brand needs; the rest are inherited from
the base swatch.

## Component-level style overrides

Individual widgets accept a `style:` parameter for one-off overrides (e.g.
`FButton(style: .delta(...), ...)`), and forui's CLI can scaffold a full style class for any
widget if you need to customize it more deeply:

```
dart run forui style create button
```

See https://forui.dev/docs for the full styling reference.
