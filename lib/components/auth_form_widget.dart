import 'dart:io';

import 'package:assocsys/components/adaptative_button_widget.dart';
import 'package:assocsys/components/adaptative_datepicker_widget.dart';
import 'package:assocsys/components/error_snackbar.dart';
import 'package:assocsys/components/user_image_picker_mobile_widget.dart';
import 'package:assocsys/components/user_image_picker_web_widget.dart';
import 'package:assocsys/core/models/auth_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthFormWidget extends StatefulWidget {
  // Metodo que vai vir do componente pai que vai executar no submit
  final Future<void> Function(AuthModel) onSubmit;
  const AuthFormWidget({super.key, required this.onSubmit});

  @override
  State<AuthFormWidget> createState() => _AuthFormWidgetState();
}

class _AuthFormWidgetState extends State<AuthFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthModel();
  DateTime? _selectedBirthDate;
  bool _isLoading = false;
  // Variável para controlar a visibilidade da senha
  bool _hidePassword = true;
  bool _hideConfirmPassword = true;
  // Variável para continuar logado ou não
  bool _continueLoggedCheck = false;

  void _handleMobileImagePick(File image) {
    _formData.image = image;
  }

  void _handleWebImagePick(Uint8List image) {
    // Converter Uint8List para File
    _formData.image = _convertUint8ListToFile(image, 'image.jpg');
  }

  File _convertUint8ListToFile(Uint8List uint8list, String fileName) {
    // Cria uma imagem temporária image.jpg e escreve os dados do Uint8List nele
    File file = File(fileName);
    file.writeAsBytesSync(uint8list);
    return file;
  }

  Future<void> _submitForm() async {
    if (mounted) {
      setState(() => _isLoading = true);
    }

    final isValid = _formKey.currentState?.validate() ?? false;
    if (_formData.isSignup && _formData.birthDate == null) {
      return ErrorSnackbar.show(context, 'Data não preenchida');
    }
    // Opcional - Obrigar o preenchimento da imagem
    // if (_formData.isSignup && _formData.image == null) {
    //   return ErrorSnackbar.show(context, 'Imagem não selecionada');
    // }
    if (!isValid) return;
    await widget.onSubmit(_formData);
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

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
                _formData.isLogin ? 'Bem vindo de volta' : 'Crie a sua conta',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              // Navegar entre os Forms de Login e Senha
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _formData.isLogin
                        ? 'Não tem uma conta ainda?'
                        : 'Já tem uma conta?',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() => _selectedBirthDate = null);
                      _formKey.currentState?.reset();
                      // Alternar entre login e signup
                      _formData.toggleAuthMode();
                    },
                    child: Text(
                      _formData.isLogin ? 'Registre-se' : 'Logar na sua conta',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),

              /// SE A PLATAFORMA FOR WEB, VAI TER QUE CHAMAR O WEB PICKER, SENÃO
              /// VAI CHAMAR O MOBILE PICKER
              Container(
                margin: const EdgeInsets.all(12),
                child: Visibility(
                  visible: _formData.isSignup,
                  child: kIsWeb
                      ? UserImagePickerWebWidget(
                          onImagePick: _handleWebImagePick,
                        )
                      : UserImagePickerMobileWidget(
                          onImagePick: _handleMobileImagePick,
                        ),
                ),
              ),
              Visibility(
                visible: _formData.isSignup,
                child: TextFormField(
                  key: const ValueKey('name'),
                  decoration: const InputDecoration(
                    labelText: 'Nome completo',
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  onChanged: (value) => _formData.name = value,
                  validator: (value) {
                    final name = value ?? '';
                    if (name.trim().isEmpty) return 'Preencha o nome';
                    return null;
                  },
                ),
              ),
              Visibility(
                visible: _formData.isSignup,
                child: TextFormField(
                  key: const ValueKey('registrationNumber'),
                  decoration: const InputDecoration(
                    labelText: 'Matrícula',
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  onChanged: (value) => _formData.registrationNumber = value,
                  validator: (value) {
                    final matricula = value ?? '';
                    if (matricula.trim().isEmpty) return 'Preencha a matrícula';
                    return null;
                  },
                ),
              ),
              Visibility(
                visible: _formData.isSignup,
                child: AdaptativeDatePickerWidget(
                  selectedDate: _selectedBirthDate,
                  onDateChange: (newDate) {
                    setState(() {
                      _formData.birthDate = newDate;
                      _selectedBirthDate = newDate;
                    });
                  },
                ),
              ),
              TextFormField(
                key: const ValueKey('email'),
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onChanged: (value) => _formData.email = value,
                validator: _formData.isLogin
                    ? null
                    : (value) {
                        final email = value ?? '';
                        // Remover espaços em branco no início e no final da string e ver se tem @
                        if (email.trim().isEmpty ||
                            !email.contains('@') ||
                            !(email.contains('.com') ||
                                email.contains('.edu.br'))) {
                          return 'Informe um email válido';
                        }
                        return null;
                      },
              ),
              TextFormField(
                key: const ValueKey('password'),
                decoration: InputDecoration(
                  labelText: 'Senha',
                  suffixIcon: IconButton(
                      icon: Icon(
                        _hidePassword ? Icons.visibility : Icons.visibility_off,
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                      onPressed: () {
                        setState(() => _hidePassword = !_hidePassword);
                      }),
                ),
                obscureText: _hidePassword,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                onChanged: (value) => _formData.password = value,
                validator: _formData.isLogin
                    ? null
                    : (value) {
                        final password = value ?? '';
                        List<String> errors = [];
                        // Verificar se a senha é vazia ou tem menos de 5 caracteres
                        if (password.isEmpty || password.length < 5) {
                          errors.add('Preencha ao menos 5 caracteres');
                        }

                        // Verificar se a senha contém pelo menos uma letra maiúscula
                        if (!password.contains(RegExp(r'[A-Z]'))) {
                          errors.add('Preencha ao menos uma letra maiúscula');
                        }

                        // Verificar se a senha contém pelo menos uma letra minúscula
                        if (!password.contains(RegExp(r'[a-z]'))) {
                          errors.add('Preencha ao menos uma letra minúscula');
                        }

                        // Verificar se a senha contém pelo menos um número
                        if (!password.contains(RegExp(r'[0-9]'))) {
                          errors.add('Preencha ao menos um número');
                        }

                        // Verificar se a senha contém pelo menos um caractere especial
                        if (!password
                            .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                          errors.add('Preencha ao menos um caractere especial');
                        }

                        // Se houver erros, retorna a mensagem concatenada; caso contrário, retorna null
                        return errors.isEmpty ? null : errors.join('\n');
                      },
              ),
              Visibility(
                visible: _formData.isSignup,
                child: TextFormField(
                  key: const ValueKey('confirmPassword'),
                  decoration: InputDecoration(
                    labelText: 'Repita a senha',
                    suffixIcon: IconButton(
                        icon: Icon(
                          _hideConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                        onPressed: () {
                          setState(() =>
                              _hideConfirmPassword = !_hideConfirmPassword);
                        }),
                  ),
                  obscureText: _hideConfirmPassword,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  validator: _formData.isLogin
                      ? null
                      : (value) {
                          final confirmPass = value ?? '';
                          if (_formData.password != confirmPass) {
                            return 'As senhas não conferem';
                          }
                          return null;
                        },
                ),
              ),

              Visibility(
                // vai trocar se for igual a false, por isso deve ser inverso
                visible: !_isLoading,
                replacement: const CircularProgressIndicator(),
                child: AdaptativeButtonWidget(
                  label: 'Registrar Associado',
                  onPressed: () => _submitForm(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/**
 * // Botão para "Esqueceu a senha".
        if (_isLogin())
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Checkbox(
                      value: _continueLoggedCheck,
                      onChanged: (value) {
                        setState(() => _continueLoggedCheck = value!);
                      }),
                  Text(
                    'Continuar logado?',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 50),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.HOME,
                    arguments: const PasswordForgetPage(),
                  );
                },
                child: Text(
                  'Esqueceu a sua senha ?',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
 */