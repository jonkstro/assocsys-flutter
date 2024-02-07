import 'package:assocsys/utils/constantes.dart';
import 'package:flutter/material.dart';

class CustomElevatedButtonTheme {
  static final lightTheme = ElevatedButtonThemeData(
    style:
        _customButtonStyle(Constantes.buttonLight, Constantes.corBrancaTextos),
  );

  static final darkTheme = ElevatedButtonThemeData(
    style: _customButtonStyle(Constantes.buttonDark, Constantes.corPretaTextos),
  );

  static ButtonStyle _customButtonStyle(
      Color backgroundColor, Color foregroundColor) {
    return ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(backgroundColor),
      foregroundColor: MaterialStatePropertyAll(foregroundColor),
    );
  }
}
