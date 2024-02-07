import 'package:assocsys/themes/custom/custom_colorscheme.dart';
import 'package:assocsys/themes/custom/custom_text_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  // light
  static final lightTheme = ThemeData(
    fontFamily: 'Open Sans',
    textTheme: CustomTextTheme.lightTheme,
    colorScheme: CustomColorScheme.lightTheme,

    useMaterial3: true,

    // ...
  );

  // dark
  static final darkTheme = ThemeData(
    fontFamily: 'Open Sans',
    textTheme: CustomTextTheme.darkTheme,
    colorScheme: CustomColorScheme.darkTheme,

    useMaterial3: true,

    // ...
  );
}

/**
 class MyAppTheme {
  // light
  static final lightTheme = ThemeData(
    appBarTheme: CustomAppBarTheme.lightAppBarTheme,
    scaffoldBackgroundColor: Colors.white,
    textTheme: CustomTextTheme.lightTheme,
    colorScheme: CustomColorScheme.lightTheme,
    elevatedButtonTheme: CustomElevatedButtonTheme.lightTheme,
    // textButtonTheme: ,
    // primaryTextTheme: ,
    // textSelectionTheme: ,
    // elevatedButtonTheme: ,

    useMaterial3: true,
  );
  // dark
  static final darkTheme = ThemeData(
    appBarTheme: CustomAppBarTheme.darkAppBarTheme,
    scaffoldBackgroundColor: Colors.black,
    textTheme: CustomTextTheme.darkTheme,
    elevatedButtonTheme: CustomElevatedButtonTheme.darkTheme,
    colorScheme: CustomColorScheme.darkTheme,
    useMaterial3: true,
  );
}
 */