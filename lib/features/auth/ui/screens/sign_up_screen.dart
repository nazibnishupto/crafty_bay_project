import 'package:crafty_bay_project/app/app_colors.dart';
import 'package:crafty_bay_project/features/auth/ui/widgets/app_logo.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static final String name = '/signUp';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _cityTEController = TextEditingController();
  final TextEditingController _addressTEController = TextEditingController();
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
                  Text("Register Account", style: textTheme.titleLarge,),
                  Text("Please enter your details to Sign Up",style: textTheme.headlineMedium,),
                  const SizedBox(height: 32,),
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
                    controller: _firstNameTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "First Name",
                    ),
                    validator: (String ? value) {
                      if(value?.trim().isEmpty ?? true){
                        return "Enter a valid First Name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _lastNameTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "Last Name",
                    ),
                    validator: (String ? value) {
                      if(value?.trim().isEmpty ?? false){
                        return "Enter a valid Last Name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _passwordTEController,
                    textInputAction: TextInputAction.next,
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
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _mobileTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "Mobile",
                    ),
                    validator: (String ? value) {
                      if(value?.trim().isEmpty ?? false){
                        return "Enter a valid Mobile Number";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _cityTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "City",
                    ),
                    validator: (String ? value) {
                      if(value?.trim().isEmpty ?? false){
                        return "Enter a valid City";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _addressTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(16),
                      hintText: "Shipping Address",
                    ),
                    maxLines: 3,
                    validator: (String ? value) {
                      if(value?.trim().isEmpty ?? false){
                        return "Enter a valid Shipping address";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16,),
                  ElevatedButton(
                    onPressed: _onTapLoginButton,
                    child: Text('Sign UP'),
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
    // Navigator.pushNamed(context, SignUpScreen.name);
    if (_formKey.currentState!.validate()) {}
  }

}
