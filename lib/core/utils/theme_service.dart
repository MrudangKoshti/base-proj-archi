import 'package:flutter/material.dart';

import 'constants.dart';



class ThemeService {
  static MaterialColor myPrimarySwatch = const MaterialColor(
    0xff1D61E7,
    <int, Color>{
      50: Color(0xff1D61E7),
      100: Color(0xff1D61E7),
      200: Color(0xff1D61E7),
      300: Color(0xff1D61E7),
      400: Color(0xff1D61E7),
      500: Color(0xff1D61E7),
      600: Color(0xff1D61E7),
      700: Color(0xff1D61E7),
      800: Color(0xff1D61E7),
      900: Color(0xff1D61E7),
    },
  );

  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primarySwatch: myPrimarySwatch,
      useMaterial3: false,
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(color: Colors.white, elevation: 0),
      );

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primarySwatch: myPrimarySwatch,
      useMaterial3: false,
     
      primaryColor: AppColors.primaryColor,
     );
}
