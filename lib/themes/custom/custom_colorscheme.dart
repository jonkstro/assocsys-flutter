import 'package:assocsys/utils/constantes.dart';
import 'package:flutter/material.dart';

class CustomColorScheme {
  // light
  static const lightTheme = ColorScheme.light(
    primary: Constantes.corFundoLogo,
    surfaceTint: Constantes.surfaceTintLight,
    error: Colors.red,
  );
  // dark
  static const darkTheme = ColorScheme.dark(
    primary: Constantes.corFundoLogo,
    surfaceTint: Constantes.surfaceTintDark,
    error: Colors.red,
  );
}
