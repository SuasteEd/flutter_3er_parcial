import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/loading_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 350,
                child: Lottie.asset('assets/json/login.json'),
              ),
              const Text('Welcome!',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: Colors.white)),
              LoginForm(
                  formKey: _formKey,
                  usernameController: usernameController,
                  passwordController: passwordController),
              CustomButton(
                text: _isPressed
                    ? const LoadingButton()
                    : const Text('Sign in', style: AppTheme.textButton),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _isPressed = true;
                    });
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('home', (route) => false);
                    });
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  TextButton(
                    onPressed: () => Get.toNamed('register'),
                    child: const Text('Sign up',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.usernameController,
    required this.passwordController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomTextFormField(
            labelText: 'User',
            hintText: 'Username',
            icon: Icons.person,
            controller: usernameController,
            keyboardType: TextInputType.emailAddress,
            validationMessage: 'Please enter a username',
            obscureText: false,
          ),
          CustomTextFormField(
              labelText: 'Password',
              hintText: 'Password',
              icon: Icons.password,
              controller: passwordController,
              keyboardType: TextInputType.visiblePassword,
              validationMessage: 'Please enter a password',
              obscureText: true),
        ],
      ),
    );
  }
}
