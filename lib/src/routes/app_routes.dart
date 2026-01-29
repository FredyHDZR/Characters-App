import 'package:flutter/material.dart';
import 'route_names.dart';
import 'package:flutter_character_app/src/screen/Home/home_screen.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(body: Center(child: Text('404'))),
        );
    }
  }
}
