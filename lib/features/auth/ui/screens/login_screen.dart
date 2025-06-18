import 'package:crafty_bay_project/app/app_colors.dart';
import 'package:crafty_bay_project/features/auth/ui/screens/sign_up_screen.dart';
import 'package:crafty_bay_project/features/auth/ui/widgets/app_logo.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

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
                  const SizedBox(height: 48,),
                  AppLogo(
                    width: 90,
                    height: 90,
                  ),
                  const SizedBox(height: 16,),
                  Text("Welcome Back", style: textTheme.titleLarge,),
                  Text("Please enter your Email & Password",style: textTheme.headlineMedium,),
                  const SizedBox(height: 24,),
                  TextFormField(
                    controller: _emailTEController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "Email",
                    ),
                    validator: (String ? value) {
                      String emailValue = value ?? '';
                      if(EmailValidator.validate(emailValue) == false){
                        return "Enter a valid Email";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _passwordTEController,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                    ),
                    validator: (String ? value) {
                      if((value?.length ?? 0) <= 6){
                        return "Please Enter a password more than 6 characters";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16,),
                  ElevatedButton(
                    onPressed: _onTapLoginButton,
                    child: Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapLoginButton() {
    Navigator.pushNamed(context, SignUpScreen.name);
    /*if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(context, SignUpScreen.name);
    }*/
  }

}
