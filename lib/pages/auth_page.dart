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
            // TODO: Se for para monitor vai ser branco e vai ter ao lado o shark.png
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
