import 'package:flutter/material.dart';
import 'package:flutter_character_app/src/routes/index.dart';
import 'package:flutter_character_app/src/theme/app_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: RouteNames.home,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
