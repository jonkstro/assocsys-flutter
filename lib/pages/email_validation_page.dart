import 'package:assocsys/core/models/associate_model.dart';
import 'package:assocsys/core/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class EmailValidationPage extends StatelessWidget {
  final AssociateModel user;
  const EmailValidationPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email validation'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            onPressed: () => AuthService().logout(),
          ),
        ],
      ),
      body: Column(
        children: [
          Text('Verifique o email ${user.email} apertando no botão abaixo'),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            icon: const Icon(Icons.email),
            label: const Text('Verificar o email'),
            onPressed: () => AuthService().activateUser(user),
          ),
        ],
      ),
    );
  }
}
