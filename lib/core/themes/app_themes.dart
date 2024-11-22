import 'package:ecommerceapp/core/themes/colours.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border([Color color = AppColors.borderColor]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      );
  static final darkThemeMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundColor,
    ),
    chipTheme: const ChipThemeData(
      color: WidgetStatePropertyAll(
        AppColors.backgroundColor,
      ),
      side: BorderSide.none,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(AppColors.gradient2),
      errorBorder: _border(AppColors.errorColor),
    ),
  );

  static const mediumTextStyle = TextStyle(
    fontSize: 24,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );
  static const bigTextStyle = TextStyle(
    fontSize: 35,
    color: Colors.black,
    fontWeight: FontWeight.w900,
  );
}
