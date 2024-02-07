import 'package:assocsys/components/auth_form_widget.dart';
import 'package:assocsys/core/models/auth_model.dart';
import 'package:assocsys/utils/constantes.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});
  Future<void> _handleSubmit(AuthModel authData) async {}
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
        child: Center(
          child: SingleChildScrollView(
            child: AuthFormWidget(
              onSubmit: _handleSubmit,
            ),
          ),
        ),
      ),
    );
  }
}
