import 'package:flutter/material.dart';

class AppTheme {
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color colorGrey = Color(0xFFD5D5D5);
  static const Color colorDarkGrey = Color(0xFF6C6C6C);
  static const Color colorGreyLight = Color(0xFFF2F2F2);
  static const Color colorPrimary = Color(0xFF016116);
  static const Color menuTextColor = Color(0xFF707070);
  static const Color colorRipple = Color(0xFF016116);
  static const Color colorSearchBg = Color(0xFFF2F2F2);
  static const Color starColor = Color(0xFFFC6011);
  static const Color primaryTransColor = Color(0xFFCB202D);
  static const Color greyBg = Color(0xFFF7F7F7);
  static const Color myCartBg = Color(0xFFFAFAFA);
  static const Color appBgColor = Color(0xFFFAFAFA);
  static const Color shimmerBaseColor = Color(0xFFF1F1F1);
  static const Color shimmerHighlightColor = Color(0xFFE0E0E0);
  static const Color shimmerChildColor = Color(0xFFF1F1F1);
  static const Color colorRed = Color.fromARGB(255, 248, 16, 36);
  static const Color colorNutral = Color(0xFFf07d08);
  static const Color colorPositive = Color(0xFF318547);
  static const Color colorNegative = Color(0xFFde0e0c);
  static const Color blueColor = Color(0xFF07338b);

  static ThemeData theme = ThemeData(
      fontFamily: 'PR',
      textTheme: const TextTheme(
          bodyText1: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w100),
          bodyText2: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w100),
          button: TextStyle(fontSize: 13.0)),
      primaryColor: white,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: colorRipple),
      navigationBarTheme: NavigationBarThemeData(
          indicatorColor: colorPrimary,
          labelTextStyle: MaterialStateProperty.all(const TextStyle(
              fontFamily: 'PR', fontSize: 13, fontWeight: FontWeight.w400))));
}
