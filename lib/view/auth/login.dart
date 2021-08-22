import 'package:flutter/material.dart';
import 'package:flutter_absensi_dosen/controller/api_controller.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  ApiController apiController = ApiController();
  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Login',
      onLogin: (loginData) => apiController.loginUser(loginData),
      onSignup: null,
      onRecoverPassword: null,
      titleTag: 'Login Aplikasi Dosen',
      emailValidator: EmailValidator(errorText: 'Masukan email yang benar'),
      hideForgotPasswordButton: true,
      hideSignUpButton: true,
      onSubmitAnimationCompleted: () {
        Navigator.pushReplacementNamed(context, '/dashboard');
      },
    );
  }
}
