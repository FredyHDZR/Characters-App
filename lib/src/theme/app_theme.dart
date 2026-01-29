import 'package:flutter/material.dart';
import 'package:flutter_character_app/src/theme/app_colors.dart';
import 'package:flutter_character_app/src/theme/app_fonts.dart';

class AppTheme {
  static ThemeData get theme => ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: AppColors.white,
    fontFamily: AppFonts.fontFamily,
    iconTheme: IconThemeData(color: AppColors.textSecondary),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.text,
      titleTextStyle: AppFonts.boldTitle.copyWith(color: AppColors.text),
      centerTitle: false,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
  );
}
