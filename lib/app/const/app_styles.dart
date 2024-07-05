import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppStyles {
  static const TextStyle appBarTitle = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
    fontSize: 12,
  );

  static const TextStyle appBarSubtitle = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w500,
    color: AppColors.textDark,
    fontSize: 10,
  );

  static const TextStyle cardTitle = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
    fontSize: 15,
  );

  static const TextStyle cardBodyTitle = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
    fontSize: 10,
  );
  static const TextStyle cardBodySubtitle = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    color: AppColors.textGrey,
    fontSize: 10,
  );

  static const TextStyle bodyDark = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,
    color: AppColors.textDark,
    fontSize: 10,
  );
  static const TextStyle bodyMediumDark = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w500,
    color: AppColors.textDark,
    fontSize: 11,
  );

  static const TextStyle primaryColorText = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w500,
    color: AppColors.primaryColor,
    fontSize: 10,
  );
  static const TextStyle primaryButtonText = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    color: Colors.white,
    fontSize: 16,
  );

// test
  static const TextStyle titleLight = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
    fontSize: 20,
  );

  static const TextStyle titleDark = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.bold,
    color: AppColors.textLight,
    fontSize: 24,
  );

  static const TextStyle bodyLight = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.normal,
    color: AppColors.textDark,
    fontSize: 16,
  );

  static const TextStyle captionLight = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.normal,
    color: AppColors.textDark,
    fontSize: 14,
  );

  static const TextStyle greySubtitle = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );

  static const TextStyle listTileTitle = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );

  static OutlineInputBorder inputBorder(Color borderColor) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: borderColor, width: 1.0),
    );
  }
}
