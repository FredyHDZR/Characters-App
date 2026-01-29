import 'package:flutter/material.dart';
import 'package:flutter_character_app/src/models/episode_model.dart';
import 'package:flutter_character_app/src/theme/app_colors.dart';
import 'package:flutter_character_app/src/theme/app_fonts.dart';

class EpisodeContainer extends StatelessWidget {
  final Episode episode;
  const EpisodeContainer({super.key, required this.episode});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: AppColors.grey.withAlpha(2), blurRadius: 10),
        ],
      ),
      child: Text(episode.broadcastCode, style: AppFonts.normalTextBold),
    );
  }
}