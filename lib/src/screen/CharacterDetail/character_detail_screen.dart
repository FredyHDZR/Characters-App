import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_character_app/src/components/building_animation.dart';
import 'package:flutter_character_app/src/components/loading_component.dart';
import 'package:flutter_character_app/src/models/character_model.dart';
import 'package:flutter_character_app/src/screen/CharacterDetail/character_detail_controller.dart';
import 'package:flutter_character_app/src/screen/CharacterDetail/components/episode_container.dart';
import 'package:flutter_character_app/src/screen/CharacterDetail/components/info_section.dart';
import 'package:flutter_character_app/src/screen/CharacterDetail/components/stat_bar.dart';
import 'package:flutter_character_app/src/theme/app_colors.dart';
import 'package:flutter_character_app/src/theme/app_fonts.dart';
import 'package:flutter_character_app/src/utils/character_stat_mock.dart';
import 'package:flutter_character_app/src/utils/constants.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CharacterDetailScreen extends StatefulWidget {
  const CharacterDetailScreen({super.key, required this.character});
  final Character character;

  @override
  State<CharacterDetailScreen> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  late CharacterDetailController controller;
  final ScrollController _scrollController = ScrollController();
  bool _isAppBarCollapsed = false;

  @override
  void initState() {
    super.initState();
    controller = CharacterDetailController(character: widget.character);
    controller.getCharacterEpisodes();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final isCollapsed = _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
    if (_isAppBarCollapsed != isCollapsed) {
      setState(() {
        _isAppBarCollapsed = isCollapsed;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (context) {
          return controller.isLoading ? loading() : body();
        },
      ),
    );
  }

  Widget body() {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          expandedHeight: 200,
          pinned: true,
          iconTheme: IconThemeData(
            color: _isAppBarCollapsed ? AppColors.primary : AppColors.white,
          ),
          backgroundColor: Colors.transparent,
          flexibleSpace: LayoutBuilder(
            builder: (context, constraints) {
              final isCollapsed = constraints.biggest.height <= kToolbarHeight;
              return Stack(
                fit: StackFit.expand,
                children: [
                  if (_isAppBarCollapsed)
                    ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          color: Colors.white.withValues(alpha: 0.1),
                        ),
                      ),
                    ),
                  FlexibleSpaceBar(
                    title: Text(
                      widget.character.name.toUpperCase(),
                      style: AppFonts.boldTitle.copyWith(
                        color: !_isAppBarCollapsed ? AppColors.white : AppColors.primary,
                      ),
                    ),
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          widget.character.image ?? '',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.image_not_supported, size: 80),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                AppColors.primary,
                                AppColors.primary.withValues(alpha: 0.3),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                ],
              );
            },
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoSection(
                  gender: widget.character.gender,
                  species: widget.character.species,
                  createdAt: widget.character.createdAt,
                ),
                const SizedBox(height: 24),
                Text(
                  episodesTitle,
                  style: AppFonts.boldTitle.copyWith(
                    fontFamily: AppFonts.fontFamily,
                  ),
                ),
                const SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: controller.episodes.length,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    childAspectRatio: 1.5,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                  ),
                  itemBuilder: (context, index) {
                    return EpisodeContainer(
                      episode: controller.episodes[index],
                    );
                  },
                ),
                const SizedBox(height: 24),
                Text(
                  statisticsTitle,
                  style: AppFonts.boldTitle.copyWith(
                    fontFamily: AppFonts.fontFamily,
                  ),
                ),
                const SizedBox(height: 16),
                ...CharacterStatMock.getMockStats(
                  widget.character.id,
                ).map((stat) => CharacterStatBar(stat: stat)),
                const SizedBox(height: 24),
                Text(comingSoon, style: AppFonts.boldTitle),
                BuildingAnimation(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
