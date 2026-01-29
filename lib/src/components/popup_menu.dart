import 'package:flutter/material.dart';
import 'package:flutter_character_app/src/theme/app_colors.dart';
import 'package:flutter_character_app/src/theme/app_fonts.dart';

class PopupMenu {
  static Future<String?> show(
    BuildContext context, {
    required RelativeRect position,
    required String title,
    required List<PopupMenuEntry<String>> items,
  }) async {
    return showMenu<String>(
      context: context,
      position: position,
      elevation: 8,
      color: AppColors.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      items: [
        PopupMenuItem<String>(
          enabled: false,
          child: Text(
            title,
            style: AppFonts.normalTextBold.copyWith(color: AppColors.text),
          ),
        ),
        PopupMenuDivider(),
        ...items,
      ],
    );
  }
}
