import 'package:crafty_bay_project/features/auth/ui/screens/login_screen.dart';
import 'package:crafty_bay_project/features/auth/ui/screens/sign_up_screen.dart';
import 'package:crafty_bay_project/features/common/ui/screens/main_bottom_nav_screen.dart';
import 'package:crafty_bay_project/features/home/ui/screens/home_screen.dart';
import 'package:crafty_bay_project/features/product/ui/screens/product_category_screen.dart';
import 'package:flutter/material.dart';

import '../features/auth/ui/screens/splash_screen.dart';
import '../features/product/ui/screens/product_list_screen.dart';

class AppRoutes {
  static Route<dynamic> routes(RouteSettings settings) {
    late final Widget screenWidget;
    if (settings.name == SplashScreen.name) {
      screenWidget = SplashScreen();
    } else if (settings.name == LoginScreen.name) {
      screenWidget = LoginScreen();
    } else if (settings.name == SignUpScreen.name) {
      screenWidget = SignUpScreen();
    } else if (settings.name == HomeScreen.name) {
      screenWidget = HomeScreen();
    } else if (settings.name == ProductCategoryScreen.name) {
      screenWidget = ProductCategoryScreen();
    } else if (settings.name == MainBottomNavScreen.name) {
      screenWidget = MainBottomNavScreen();
    } else if (settings.name == ProductListScreen.name) {
      final String category = settings.arguments as String;
      screenWidget = ProductListScreen(category: category);
    }
    return MaterialPageRoute(builder: (context) => screenWidget);
  }
}
