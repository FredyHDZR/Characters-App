// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_character_app/src/components/circle_icon_button.dart';
import 'package:flutter_character_app/src/components/popup_menu.dart';
import 'package:flutter_character_app/src/models/character_model.dart';
import 'package:flutter_character_app/src/screen/Home/components/character_item.dart';
import 'package:flutter_character_app/src/theme/app_colors.dart';
import 'package:flutter_character_app/src/theme/app_fonts.dart';
import 'package:flutter_character_app/src/utils/constants.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lottie/lottie.dart';

import 'components/search_bar.dart';
import 'home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = HomeController();
  final GlobalKey _filterButtonKey = GlobalKey();

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
        value: 'gender',
        child: Text(
          'Género',
          style: AppFonts.normalText.copyWith(color: AppColors.text),
        ),
      ),
      PopupMenuItem<String>(
        value: 'species',
        child: Text(
          'Especie',
          style: AppFonts.normalText.copyWith(color: AppColors.text),
        ),
      ),
      PopupMenuItem<String>(
        value: 'clear_all',
        child: Text(
          'Limpiar filtros',
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

    return PopupMenu.show(context, position: position, title: title, items: items);
  }

  Future<void> _openFilterMenu(BuildContext context) async {
    final category = await _showFilterCategoryMenu(context);
    if (!mounted || category == null) return;

    if (category == 'clear_all') {
      controller.clearFilters();
      return;
    }

    if (category == 'gender') {
      final value = await _showFilterValueMenu(
        context: context,
        title: 'Género',
        values: controller.availableGenders,
        selectedValue: controller.selectedGender,
      );
      if (!mounted || value == null) return;
      controller.setSelectedGender(value);
      return;
    }

    if (category == 'species') {
      final value = await _showFilterValueMenu(
        context: context,
        title: 'Especie',
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
    controller.toggleLoading();
    List<Character> characters = (mockData['items'] as List<dynamic>)
        .map((e) => Character.fromJson(e))
        .toList();
    controller.setCharacters(characters);
    Future.delayed(Duration(seconds: 5), () {
      controller.toggleLoading();
    });
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
        spacing: 10,
        children: [
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
                  return Center(child: Text('No se encontraron personajes'));
                }
                return ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  itemCount: controller.filteredCharacters.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => CharacterItem(
                    character: controller.filteredCharacters[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget loading() {
    return Center(
      child: Lottie.asset(loadingAnimation, width: 150, height: 150),
    );
  }
}
