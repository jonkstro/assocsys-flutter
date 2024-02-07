import 'package:assocsys/core/services/auth/auth_service.dart';
import 'package:assocsys/pages/auth_page.dart';
import 'package:assocsys/pages/loading_page.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingPage();
        } else {
          // Se não tiver dados na stream (null) vai pra tela de authpage
          return snapshot.hasData ? const HomePage() : const AuthPage();
        }
        // TODO: Adicionar uma tela caso dê erro
      },
    );
  }
}
