import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_styles.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      cardColor: Colors.white,
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      textTheme: const TextTheme(
        displayLarge: AppStyles.titleDark,
        bodyMedium: AppStyles.bodyDark,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputFillDark,
        border: AppStyles.inputBorder(AppColors.inputBorderDark),
        enabledBorder: AppStyles.inputBorder(AppColors.inputBorderDark),
        focusedBorder: AppStyles.inputBorder(AppColors.primaryColor),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
          foregroundColor: MaterialStateProperty.all(AppColors.textLight),
          textStyle: MaterialStateProperty.all(AppStyles.bodyDark),
        ),
      ),
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: AppColors.accentColor),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      textTheme: const TextTheme(
        displayLarge: AppStyles.titleLight,
        bodyMedium: AppStyles.bodyLight,
      ),
      cardColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputFillLight,
        border: AppStyles.inputBorder(AppColors.inputBorderLight),
        enabledBorder: AppStyles.inputBorder(AppColors.inputBorderLight),
        focusedBorder: AppStyles.inputBorder(AppColors.primaryColor),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
          foregroundColor: MaterialStateProperty.all(AppColors.textLight),
          textStyle: MaterialStateProperty.all(AppStyles.bodyLight),
        ),
      ),
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: AppColors.accentColor),
    );
  }
}
