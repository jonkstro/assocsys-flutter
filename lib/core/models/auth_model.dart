import 'dart:io';

enum AuthMode { signup, login }

class AuthModel {
  String name = '';
  String registrationNumber = '';
  DateTime? birthDate;
  String email = '';
  String password = '';
  File? image;
  DateTime registrationDate = DateTime.now();

  // Iniciar na tela de login
  AuthMode _mode = AuthMode.login;

  // Getters que irão retornar se está em login ou signup
  bool get isLogin {
    return _mode == AuthMode.login;
  }

  bool get isSignup {
    return _mode == AuthMode.signup;
  }

  void toggleAuthMode() {
    // Se tiver login, muda pra signup, senão muda pra login
    _mode = isLogin ? AuthMode.signup : AuthMode.login;
  }
}
