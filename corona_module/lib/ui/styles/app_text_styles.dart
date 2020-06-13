import 'package:flutter/material.dart';

import 'styles.dart';


class AppTextStyles {
  static const TextStyle _baseSansSerif = TextStyle(
    color: AppColors.background,
    fontFamily: 'Sen',
  );

  // Dark Sans Serif
  static final TextStyle extraLargeDark = _baseSansSerif.copyWith(
    fontSize: 28.0,
    fontWeight: FontWeight.w700,
    letterSpacing: 1,
  );

  static final TextStyle largeDark = _baseSansSerif.copyWith(
    fontSize: 22.0,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle mediumDark = _baseSansSerif.copyWith(
    fontSize: 18.0,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle smallDark = _baseSansSerif.copyWith(
    color: Colors.black87,
    fontSize: 15.0,
    fontWeight: FontWeight.w200,
  );

  static final TextStyle extraSmallDark = _baseSansSerif.copyWith(
    color: Colors.black54,
    fontSize: 11.0,
    fontWeight: FontWeight.w200,
  );

  // Light Sans Serif
  static final TextStyle extraLargeLight = extraLargeDark.copyWith(
    color: AppColors.light,
  );

  static final TextStyle largeLight = largeDark.copyWith(
    color: AppColors.light,
  );

  static final TextStyle mediumLight = mediumDark.copyWith(
    color: AppColors.light,
  );

  static final TextStyle smallLight = smallDark.copyWith(
    color: AppColors.light.withOpacity(0.8),
  );

  static final TextStyle extraSmallLight = extraSmallDark.copyWith(
    color: AppColors.light.withOpacity(0.6),
  );

  // Serif
  static const TextStyle _baseSerif = TextStyle(
    color: AppColors.background,
    fontFamily: 'Sura',
  );

  // Dark Serif
  static final TextStyle extraLargeDarkSerif = _baseSerif.copyWith(
    fontSize: 28.0,
    fontWeight: FontWeight.w700,
    letterSpacing: 1,
  );

  static final TextStyle largeDarkSerif = _baseSerif.copyWith(
    fontSize: 22.0,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle mediumDarkSerif = _baseSerif.copyWith(
    fontSize: 18.0,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle smallDarkSerif = _baseSerif.copyWith(
    fontSize: 15.0,
    fontWeight: FontWeight.w200,
  );

  // Light Serif
  static final TextStyle extraLargeLightSerif = extraLargeDarkSerif.copyWith(
    color: AppColors.light,
  );

  static final TextStyle largeLightSerif = largeDarkSerif.copyWith(
    color: AppColors.light,
  );

  static final TextStyle mediumLightSerif = mediumDarkSerif.copyWith(
    color: AppColors.light,
  );

  static final TextStyle smallLightSerif = smallDarkSerif.copyWith(
    color: Colors.white70,
  );
}
