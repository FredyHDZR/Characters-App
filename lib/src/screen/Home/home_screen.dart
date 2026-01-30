// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_character_app/src/components/circle_icon_button.dart';
import 'package:flutter_character_app/src/components/loading_component.dart';
import 'package:flutter_character_app/src/components/popup_menu.dart';
import 'package:flutter_character_app/src/routes/index.dart';
import 'package:flutter_character_app/src/screen/Home/components/character_item.dart';
import 'package:flutter_character_app/src/theme/app_colors.dart';
import 'package:flutter_character_app/src/theme/app_fonts.dart';
import 'package:flutter_character_app/src/utils/constants.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'components/search_bar.dart';
import 'components/series_banner.dart';
import 'home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = HomeController();
  final GlobalKey _filterButtonKey = GlobalKey();
  final GlobalKey _seriesBannerKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  RelativeRect? _menuPositionFromKey(BuildContext context, GlobalKey key) {
    final buttonContext = key.currentContext;
    if (buttonContext == null) return null;

    final buttonBox = buttonContext.findRenderObject() as RenderBox?;
    final overlayBox =
        Overlay.of(context).context.findRenderObject() as RenderBox?;
    if (buttonBox == null || overlayBox == null) return null;

    final offset = buttonBox.localToGlobal(Offset.zero, ancestor: overlayBox);
    final size = buttonBox.size;

    final rect = Rect.fromLTWH(
      offset.dx,
      offset.dy + size.height,
      size.width,
      size.height,
    );
    return RelativeRect.fromRect(rect, Offset.zero & overlayBox.size);
  }

  Future<String?> _showFilterCategoryMenu(BuildContext context) async {
    final position = _menuPositionFromKey(context, _filterButtonKey);
    if (position == null) return null;

    var items = <PopupMenuEntry<String>>[
      PopupMenuItem<String>(
        value: genderKey,
        child: Text(
          genderTitle,
          style: AppFonts.normalText.copyWith(color: AppColors.text),
        ),
      ),
      PopupMenuItem<String>(
        value: speciesKey,
        child: Text(
          speciesTitle,
          style: AppFonts.normalText.copyWith(color: AppColors.text),
        ),
      ),
      PopupMenuItem<String>(
        value: clearAllKey,
        child: Text(
          clearAllTitle,
          style: AppFonts.normalText.copyWith(color: AppColors.text),
        ),
      ),
    ];

    return PopupMenu.show(
      context,
      position: position,
      title: filterByTitle,
      items: items,
    );
  }

  Future<String?> _showFilterValueMenu({
    required BuildContext context,
    required String title,
    required List<String> values,
    required String? selectedValue,
  }) async {
    final position = _menuPositionFromKey(context, _filterButtonKey);
    if (position == null) return null;

    final items = <PopupMenuEntry<String>>[
      ...values.map(
        (v) => PopupMenuItem<String>(
          value: v,
          child: Row(
            children: [
              Expanded(child: Text(v)),
              if (selectedValue == v) const Icon(Icons.check, size: 18),
            ],
          ),
        ),
      ),
    ];

    return PopupMenu.show(
      context,
      position: position,
      title: title,
      items: items,
    );
  }

  Future<String?> _showSeriesMenu(
    BuildContext context,
    String seriesName,
  ) async {
    final position = _menuPositionFromKey(context, _seriesBannerKey);
    if (position == null) return null;

    final items = <PopupMenuEntry<String>>[
      ...controller.seriesNames.map(
        (s) => PopupMenuItem<String>(
          value: s,
          child: Text(
            s,
            style: AppFonts.normalTextBold.copyWith(color: AppColors.text),
          ),
        ),
      ),
    ];

    return PopupMenu.show(
      context,
      position: position,
      title: seriesTitle,
      items: items,
    );
  }

  Future<void> _showSeriesDetail(
    BuildContext context,
    String seriesName,
  ) async {
    final value = await _showSeriesMenu(context, controller.selectedSeries);
    if (!mounted || value == null) return;
    Navigator.pushNamed(context, RouteNames.showDetail, arguments: value);
  }

  Future<void> _openFilterMenu(BuildContext context) async {
    final category = await _showFilterCategoryMenu(context);
    if (!mounted || category == null) return;

    if (category == clearAllKey) {
      controller.clearFilters();
      return;
    }

    if (category == genderKey) {
      final value = await _showFilterValueMenu(
        context: context,
        title: genderTitle,
        values: controller.availableGenders,
        selectedValue: controller.selectedGender,
      );
      if (!mounted || value == null) return;
      controller.setSelectedGender(value);
      return;
    }

    if (category == speciesKey) {
      final value = await _showFilterValueMenu(
        context: context,
        title: speciesTitle,
        values: controller.availableSpecies,
        selectedValue: controller.selectedSpecies,
      );
      if (!mounted || value == null) return;
      controller.setSelectedSpecies(value);
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    controller.getCharacters();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      if (controller.hasMore && !controller.isLoadingMore) {
        controller.loadMoreCharacters();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          homeTitle,
          style: AppFonts.boldTitle.copyWith(
            color: AppColors.text,
            fontFamily: AppFonts.fontFamily,
          ),
        ),
      ),
      body: body(),
    );
  }

  Widget body() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          SeriesBanner(
            key: _seriesBannerKey,
            seriesName: controller.selectedSeries,
            onPressed: () =>
                _showSeriesDetail(context, controller.selectedSeries),
          ),
          Row(
            spacing: 16,
            children: [
              Expanded(
                child: CustomSearchBar(
                  onSearch: (value) {
                    controller.setSearchQuery(value);
                  },
                ),
              ),
              CircleIconButton(
                key: _filterButtonKey,
                icon: Icons.filter_list,
                onPressed: () => _openFilterMenu(context),
              ),
            ],
          ),
          Expanded(
            child: Observer(
              builder: (context) {
                if (controller.isLoading) {
                  return loading();
                }
                if (controller.filteredCharacters.isEmpty) {
                  return Center(
                    child: Text(
                      noCharactersFound,
                      style: AppFonts.normalText.copyWith(
                        color: AppColors.text,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(vertical: 24),
                  itemCount:
                      controller.filteredCharacters.length +
                      (controller.isLoadingMore ? 1 : 0),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (index == controller.filteredCharacters.length) {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    return GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        RouteNames.characterDetail,
                        arguments: controller.filteredCharacters[index],
                      ),
                      child: CharacterItem(
                        character: controller.filteredCharacters[index],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
