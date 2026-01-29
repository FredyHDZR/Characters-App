import 'package:flutter/material.dart';
import 'package:flutter_character_app/src/theme/app_colors.dart';

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
  });
  final IconData icon;
  final VoidCallback onPressed;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      shape: CircleBorder(),
      fillColor: backgroundColor ?? AppColors.background,
      constraints: BoxConstraints(minWidth: 50, minHeight: 50),
      child: Icon(icon),
    );
  }
}
