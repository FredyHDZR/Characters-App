import 'package:flutter/material.dart';
import 'package:flutter_character_app/src/models/character_model.dart';
import 'package:flutter_character_app/src/screen/CharacterDetail/character_detail_screen.dart';
import 'package:flutter_character_app/src/screen/ShowDetail/show_detail_screen.dart';
import 'route_names.dart';
import 'package:flutter_character_app/src/screen/Home/home_screen.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case RouteNames.characterDetail:
        return MaterialPageRoute(
          builder: (context) =>
              CharacterDetailScreen(character: settings.arguments as Character),
        );
      case RouteNames.showDetail:
        return MaterialPageRoute(
          builder: (context) => ShowDetailScreen(seriesName: settings.arguments as String),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(body: Center(child: Text('404'))),
        );
    }
  }
}
