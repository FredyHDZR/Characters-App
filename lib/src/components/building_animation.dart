import 'package:flutter/material.dart';
import 'package:flutter_character_app/src/theme/app_fonts.dart';
import 'package:flutter_character_app/src/utils/constants.dart';
import 'package:lottie/lottie.dart';

class BuildingAnimation extends StatelessWidget {
  const BuildingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: Lottie.asset(buildingAnimation, height: 300)),
        Text(
          comingSoonMessage,
          style: AppFonts.normalTitle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
