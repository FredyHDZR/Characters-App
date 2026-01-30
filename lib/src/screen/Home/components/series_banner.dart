import 'package:flutter/material.dart';
import 'package:flutter_character_app/src/theme/app_colors.dart';
import 'package:flutter_character_app/src/theme/app_fonts.dart';

class SeriesBanner extends StatelessWidget {
  final String seriesName;
  final Function() onPressed;
  const SeriesBanner({super.key, required this.seriesName, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          spacing: 8,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              seriesName,
              style: AppFonts.normalTextBold.copyWith(
                color: AppColors.white,
                fontFamily: AppFonts.fontFamily,
              ),
            ),
            Icon(Icons.keyboard_arrow_down, color: AppColors.white, size: 16),
          ],
        ),
      ),
    );
  }
}
