import 'package:flutter/material.dart';
import 'package:flutter_character_app/src/models/character_model.dart';
import 'package:flutter_character_app/src/theme/app_colors.dart';
import 'package:flutter_character_app/src/theme/app_fonts.dart';

class CharacterItem extends StatelessWidget {
  final Character character;
  const CharacterItem({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: AppColors.grey.withAlpha(2), blurRadius: 10),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              character.image ?? '',
              fit: BoxFit.fill,
              width: double.infinity,
              height: 250,
              errorBuilder: (context, error, stackTrace) => Icon(Icons.image_not_supported, size: 80),
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary.withAlpha(0), AppColors.primary],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  character.name,
                  style: AppFonts.normalTextBold.copyWith(
                    color: AppColors.white,
                  ),
                ),
                Text(
                  character.species,
                  style: AppFonts.normalText.copyWith(color: AppColors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
