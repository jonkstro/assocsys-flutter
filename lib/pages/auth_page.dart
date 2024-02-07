import 'package:assocsys/components/auth_form_widget.dart';
import 'package:assocsys/utils/constantes.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Constantes.corFundoLogo,
              Colors.blue,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: const Center(
          child: AuthFormWidget(),
        ),
      ),
    );
  }
}
