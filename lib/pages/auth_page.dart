import 'package:assocsys/components/auth_form_widget.dart';
import 'package:assocsys/core/models/auth_model.dart';
import 'package:assocsys/core/services/auth/auth_service.dart';
import 'package:assocsys/utils/constantes.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    bool _isLoading = false;
    Future<void> _handleSubmit(AuthModel authModel) async {
      if (mounted) {
        setState(() => _isLoading = true);
      }
      try {
        if (authModel.isLogin) {
          // login
          await AuthService().login(authModel.email, authModel.password);
        } else {
          // signup
          await AuthService().signup(
            authModel.name,
            authModel.email,
            authModel.password,
            authModel.image,
            authModel.registrationNumber,
            // vai ter a data do nascimento, pois se não enviar no form ele dá erro
            // caso não tenha, pra não quebrar o app, bota a data de agora.
            authModel.birthDate ?? DateTime.now(),
            authModel.registrationDate,
          );
        }
      } catch (error) {
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
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
          // Quando tiver carregando a página vai ficar "pensando"
          if (_isLoading)
            Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.5),
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
        ],
      ),
    );
  }
}
