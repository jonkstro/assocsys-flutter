import 'package:assocsys/core/services/auth/auth_service.dart';
import 'package:assocsys/pages/auth_page.dart';
import 'package:assocsys/pages/email_validation_page.dart';
import 'package:assocsys/pages/loading_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'home_page.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({super.key});

  // Iniciar a aplicação (conexão do Firebase, etc...)
  Future<void> init(BuildContext context) async {
    // Inicializar o pacote dotenv carregando as variáveis de ambiente
    await dotenv.load(fileName: '.env');
    // Iniciar o Firebase para fazer a autenticação e firestore
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingPage();
        } else {
          return StreamBuilder(
            stream: AuthService().userChanges,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingPage();
              } else {
                // Se não tiver dados na stream (null) vai pra tela de authpage
                if (!snapshot.hasData) {
                  return const AuthPage();
                } else {
                  if (!snapshot.data!.isActive) {
                    return EmailValidationPage(
                      user: snapshot.data!,
                    );
                  }
                }
                return const HomePage();
              }
              // TODO: Adicionar uma tela caso dê erro
            },
          );
        }
      },
    );
  }
}
