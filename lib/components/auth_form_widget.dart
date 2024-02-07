import 'dart:io';

import 'package:assocsys/components/user_image_picker_mobile_widget.dart';
import 'package:assocsys/components/user_image_picker_web_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthFormWidget extends StatefulWidget {
  const AuthFormWidget({super.key});

  @override
  State<AuthFormWidget> createState() => _AuthFormWidgetState();
}

class _AuthFormWidgetState extends State<AuthFormWidget> {
  final _formKey = GlobalKey<FormState>();
  // final _formData = AuthFormModel();

  void _handleMobileImagePick(File image) {}
  void _handleWebImagePick(Uint8List image) {}

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(
          maxWidth: 800,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                'Crie a sua conta',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),

              /// SE A PLATAFORMA FOR WEB, VAI TER QUE CHAMAR O WEB PICKER, SENÃO
              /// VAI CHAMAR O MOBILE PICKER
              kIsWeb
                  ? UserImagePickerWebWidget(
                      onImagePick: _handleWebImagePick,
                    )
                  : UserImagePickerMobileWidget(
                      onImagePick: _handleMobileImagePick,
                    ),
              TextFormField(
                key: const ValueKey('name'),
                decoration: const InputDecoration(
                  labelText: 'Nome completo',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
