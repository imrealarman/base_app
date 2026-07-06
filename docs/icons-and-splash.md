# App icon & splash screen

Both are generated from a single source image using
[flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) and
[flutter_native_splash](https://pub.dev/packages/flutter_native_splash), configured in
`pubspec.yaml` — the same drop-in-a-file convention as the app font (see [fonts.md](fonts.md)).

## Changing the icon/splash image

1. Replace `lib/assets/icon/icon.png` with your own image — **1024x1024px, PNG, no
   transparency for the icon** (a transparent icon looks fine on some launchers and broken on
   others; flatten it onto a background color first).
2. Regenerate:

   ```
   dart run flutter_launcher_icons
   dart run flutter_native_splash:create
   ```

   These write directly into `android/` and `ios/` (icon sizes, launch screens, styles.xml,
   Info.plist keys) — commit the resulting native changes alongside the image.

3. To restore Flutter's default white splash screen instead: `dart run flutter_native_splash:remove`.

## Configuration reference

Both packages are configured in `pubspec.yaml` under their own top-level keys:

```yaml
flutter_launcher_icons:
  android: "launcher_icon"
  ios: true
  image_path: "lib/assets/icon/icon.png"
  min_sdk_android: 21

flutter_native_splash:
  color: "#FFFFFF"
  color_dark: "#18181B"
  image: "lib/assets/icon/icon.png"
  android_12:
    image: "lib/assets/icon/icon.png"
    color: "#FFFFFF"
    color_dark: "#18181B"
```

`color`/`color_dark` are the splash background for light/dark mode; `android_12` is required
separately since Android 12+ handles splash screens natively and ignores the legacy keys.

## Multiple environments (dev/staging/prod)

Since dev, staging, and prod builds can be installed side-by-side on the same device once
Android/iOS build flavors are introduced, give each environment a **visually distinct icon** —
e.g. the same base icon with a small "DEV"/"STG" badge overlay — so testers can tell them
apart at a glance. This template doesn't set up build flavors by default (see
[environments.md](environments.md) for how environments are currently selected via separate
entrypoints instead); if you add flavors later, point each flavor's
`flutter_launcher_icons`/`flutter_native_splash` config at its own badged image.
