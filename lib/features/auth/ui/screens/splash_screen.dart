import 'package:crafty_bay_project/features/auth/ui/screens/login_screen.dart';
import 'package:crafty_bay_project/features/auth/ui/screens/sign_up_screen.dart';
import 'package:crafty_bay_project/features/common/ui/screens/main_bottom_nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../common/controllers/auth_controller.dart';
import '../widgets/app_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static final String name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToLoginScreen();
  }

  Future<void> _moveToLoginScreen() async {
    await Future.delayed(Duration(seconds: 2));
    await Get.find<AuthController>().getUserData();
    Navigator.pushReplacementNamed(context, LoginScreen.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Spacer(),
              AppLogo(),
              Spacer(),
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text('Version 1.0.0', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}
