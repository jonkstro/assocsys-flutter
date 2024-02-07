import 'package:assocsys/themes/custom/custom_colorscheme.dart';
import 'package:assocsys/themes/custom/custom_elevatedbutton_theme.dart';
import 'package:assocsys/themes/custom/custom_text_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static const String _fontFamily = 'Open Sans';
  // light
  static final lightTheme = _customThemeData(
    textTheme: CustomTextTheme.lightTheme,
    colorScheme: CustomColorScheme.lightTheme,
    elevatedButtonTheme: CustomElevatedButtonTheme.lightTheme,
  );

  // dark
  static final darkTheme = _customThemeData(
    textTheme: CustomTextTheme.darkTheme,
    colorScheme: CustomColorScheme.darkTheme,
    elevatedButtonTheme: CustomElevatedButtonTheme.darkTheme,
  );
  static ThemeData _customThemeData({
    TextTheme? textTheme,
    ColorScheme? colorScheme,
    ElevatedButtonThemeData? elevatedButtonTheme,
  }) {
    return ThemeData(
      fontFamily: _fontFamily,
      useMaterial3: true,
      textTheme: textTheme,
      colorScheme: colorScheme,
      elevatedButtonTheme: elevatedButtonTheme,

      // Adicionar mais configurações ...
    );
  }
}
