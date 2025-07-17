import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightThemeData {
    return ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: AppColors.getMaterialColor(AppColors.themeColor),
      ),
      textTheme: _textTheme,
      inputDecorationTheme: _inputDecorationTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      appBarTheme: _appBarTheme,
    );
  }

  static TextTheme get _textTheme {
    return TextTheme(
      titleLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.4,
      ),
      titleMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.4,
      ),
      titleSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.4,
      ),
      headlineMedium: TextStyle(
          fontSize: 16,
          color: Colors.grey
      ),
    );
  }

  static InputDecorationTheme get _inputDecorationTheme {
    return InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
      border: _getInputBorder(AppColors.themeColor),
      enabledBorder: _getInputBorder(AppColors.themeColor),
      focusedBorder: _getInputBorder(AppColors.themeColor),
      errorBorder: _getInputBorder(Colors.red),
      hintStyle: TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.grey,
      )
    );
  }

  static OutlineInputBorder _getInputBorder(Color color){
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 1.2),
    );
  }

  static ElevatedButtonThemeData get _elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size.fromWidth(double.maxFinite),
        backgroundColor: AppColors.themeColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
        textStyle: const TextStyle(
          fontSize: 16,
          letterSpacing: 0.4,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  static AppBarTheme get _appBarTheme {
    return AppBarTheme(
      titleTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.black87,
      ),
    );
  }

}
