import 'package:flutter/foundation.dart';
import 'package:forui/forui.dart';

import 'app_fonts.dart';

const _touchPlatforms = {
  TargetPlatform.android,
  TargetPlatform.iOS,
  TargetPlatform.fuchsia,
};

/// Builds the zinc forui theme for [brightness], with [appFontFamily] applied
/// across every text style (forui widgets and the approximated Material theme).
FThemeData resolveFTheme({required Brightness brightness}) {
  final isTouch = _touchPlatforms.contains(defaultTargetPlatform);
  final colors = brightness == Brightness.dark
      ? FColors.zincDark
      : FColors.zincLight;
  final typeface = FTypeface.inherit(
    colors: colors,
    touch: isTouch,
    fontFamily: appFontFamily,
  );
  final typography = FTypography(display: typeface, body: typeface);

  return FThemeData(
    colors: colors,
    touch: isTouch,
    typography: typography,
    debugLabel:
        'Zinc ${brightness.name} ${isTouch ? 'Touch' : 'Desktop'} ($appFontFamily)',
  );
}
