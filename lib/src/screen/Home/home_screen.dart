import 'package:flutter/material.dart';
import 'package:flutter_character_app/src/components/circle_icon_button.dart';
import 'package:flutter_character_app/src/models/character_model.dart';
import 'package:flutter_character_app/src/screen/Home/components/character_item.dart';
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
      appBar: AppBar(title: Text(homeTitle)),
      body: body(),
    );
  }

  Widget body() {
    final characterList = ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 24),
      itemCount: controller.characters.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return CharacterItem(character: controller.characters[index]);
      },
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        spacing: 10,
        children: [
          Row(
            spacing: 16,
            children: [
              Expanded(child: CustomSearchBar(onSearch: (value) {})),
              CircleIconButton(icon: Icons.filter_list, onPressed: () {}),
            ],
          ),
          Expanded(
            child: Observer(
              builder: (context) =>
                  controller.isLoading ? loading() : characterList,
            ),
          ),
        ],
      ),
    );
  }

  Widget loading() {
    return Center(
      child: Lottie.asset(
        loadingAnimation,
        width: 150,
        height: 150,
      ),
    );
  }
}
