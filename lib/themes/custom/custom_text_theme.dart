import 'package:assocsys/utils/constantes.dart';
import 'package:flutter/material.dart';

class CustomTextTheme {
  // light
  static const lightTheme = TextTheme(
    bodySmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.normal,
      color: Constantes.corPretaTextos,
    ),
    headlineMedium: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Constantes.corPretaTextos,
    ),
    headlineLarge: TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.bold,
      color: Constantes.corBrancaTextos,
    ),
  );
  // dark
  static const darkTheme = TextTheme(
    bodySmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.normal,
      color: Constantes.corBrancaTextos,
    ),
    headlineMedium: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Constantes.corBrancaTextos,
    ),
  );
}
