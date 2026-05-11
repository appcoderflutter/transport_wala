import 'package:flutter/material.dart';
import 'package:transport_wala/resources/text_styes/custome_text.dart';

import '../utility/const.dart';
import 'mColours.dart';

class AppTheme {
  AppTheme._();
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    fontFamily: Consts.font,
    scaffoldBackgroundColor: MColors.colorPrimary,
    textTheme: TextTheme(
      displayLarge: CustomTextTheme.veryBig(),
      headlineLarge: CustomTextTheme.big(),
      titleLarge: CustomTextTheme.title(),
      bodyLarge: CustomTextTheme.desc(),
      bodyMedium: CustomTextTheme.regular(),
      bodySmall: CustomTextTheme.small(),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}
