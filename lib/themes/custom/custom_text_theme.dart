import 'package:assocsys/utils/constantes.dart';
import 'package:flutter/material.dart';

class CustomTextTheme {
  static const _fontSizeSmall = 18.0;
  static const _fontSizeMedium = 30.0;

  static final lightTheme = TextTheme(
    bodySmall: _customTextStyle(Constantes.corPretaTextos),
    bodyMedium: _customTextStyle(Constantes.corPretaTextos,
        fontWeight: FontWeight.bold),
    headlineMedium: _customTextStyle(Constantes.corPretaTextos,
        fontWeight: FontWeight.bold, fontSize: _fontSizeMedium),
    headlineLarge: _customTextStyle(Constantes.corBrancaTextos,
        fontWeight: FontWeight.bold, fontSize: _fontSizeMedium + 10),
  );

  static final darkTheme = TextTheme(
    bodySmall: _customTextStyle(Constantes.corBrancaTextos),
    bodyMedium: _customTextStyle(Constantes.corBrancaTextos,
        fontWeight: FontWeight.bold),
    headlineMedium: _customTextStyle(Constantes.corBrancaTextos,
        fontWeight: FontWeight.bold, fontSize: _fontSizeMedium),
  );

  // Evitar repetir TextStyle
  static TextStyle _customTextStyle(Color color,
      {FontWeight? fontWeight, double? fontSize}) {
    return TextStyle(
      fontSize: fontSize ?? _fontSizeSmall,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color,
    );
  }
}
