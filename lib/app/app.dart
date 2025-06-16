
import 'package:crafty_bay_project/app/app_routes.dart';
import 'package:crafty_bay_project/app/app_theme.dart';
import 'package:crafty_bay_project/features/auth/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class CraftyBay extends StatefulWidget {
  const CraftyBay({super.key});

  @override
  State<CraftyBay> createState() => _CraftyBayState();
}

class _CraftyBayState extends State<CraftyBay> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: SplashScreen.name,
      theme: AppTheme.lightThemeData,
      onGenerateRoute: AppRoutes.routes,
    );
  }
}
