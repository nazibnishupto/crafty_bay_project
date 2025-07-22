import 'package:crafty_bay_project/app/app_colors.dart';
import 'package:crafty_bay_project/features/auth/ui/screens/sign_up_screen.dart';
import 'package:crafty_bay_project/features/auth/ui/widgets/app_logo.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../core/ui/widgets/centered_circular_progress_indicator.dart';
import '../../../../core/ui/widgets/snack_bar_message.dart';
import '../../../common/ui/screens/main_bottom_nav_screen.dart';
import '../../data/models/login_request_model.dart';
import '../controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static final String name = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LoginController _loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  const SizedBox(height: 48),
                  AppLogo(width: 90, height: 90),
                  const SizedBox(height: 16),
                  Text("Welcome Back", style: textTheme.titleLarge),
                  Text(
                    "Please enter your Email & Password",
                    style: textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _emailTEController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: "Email"),
                    validator: (String? value) {
                      String emailValue = value ?? '';
                      if (EmailValidator.validate(emailValue) == false) {
                        return "Enter a valid Email";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordTEController,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    decoration: InputDecoration(hintText: "Password"),
                    validator: (String? value) {
                      if ((value?.length ?? 0) <= 6) {
                        return "Please Enter a password more than 6 characters";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  GetBuilder<LoginController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.inProgress == false,
                        replacement: CenteredCircularProgressIndicator(),
                        child: Column(
                          children: [
                            ElevatedButton(
                              onPressed: _onTapLoginButton,
                              child: Text('Login'),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "New to Crafty Bay?",
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(color: Colors.black),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      SignUpScreen.name,
                                    );
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      color: AppColors.themeColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onTapLoginButton() async {
    if (_formKey.currentState!.validate()) {
      LoginRequestModel model = LoginRequestModel(
        email: _emailTEController.text.trim(),
        password: _passwordTEController.text,
      );
      final bool isSuccess = await _loginController.login(model);
      if (isSuccess) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          MainBottomNavScreen.name,
          (predicate) => false,
        );
      } else {
        showSnackBarMessage(context, _loginController.errorMessage!, true);
      }
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
