import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:assocsys/core/models/associate_model.dart';
import 'package:assocsys/core/services/auth/auth_service.dart';

class AuthMockService implements AuthService {
  // static final AssociateModel _defaultAssociate = AssociateModel(
  //   id: '1',
  //   name: 'teste',
  //   registrationNumber: '123',
  //   birthDate: DateTime.now().toIso8601String(),
  //   email: 'email',
  //   password: 'password',
  //   imageUrl: 'imageUrl',
  //   registrationDate: 'registrationDate',
  // );

  static Map<String, AssociateModel> _associates = {
    // _defaultAssociate.email: _defaultAssociate,
  };

  static AssociateModel? _currentUser;

  static MultiStreamController<AssociateModel?>? _controller;
  static final _userStream = Stream<AssociateModel?>.multi((controller) {
    _controller = controller;
    _updateUser(null);
  });

  @override
  // Retornar o associado logado
  AssociateModel? get currentUser => _currentUser;

  @override
  // Retornar as streams de users
  Stream<AssociateModel?> get userChanges => _userStream;

  @override
  Future<void> login(String email, String password) async {
    // Vai buscar no Map pelo email passado e adicionar no update
    _updateUser(_associates[email]);
  }

  @override
  Future<void> logout() async {
    // vai zerar o user atual e botar um novo dado null na stream
    _updateUser(null);
  }

  @override
  Future<void> signup(
    String name,
    String email,
    String password,
    File? image,
    String registrationNumber,
    DateTime birthDate,
    DateTime registrationDate,
  ) async {
    final newUser = AssociateModel(
      id: Random().nextDouble().toString(),
      name: name,
      registrationNumber: registrationNumber,
      birthDate: birthDate.toIso8601String(),
      email: email,
      // se não receber a imagem do formData vai botar uma imagem padrão
      imageUrl: image?.path ?? 'assets/images/avatar.png',
      registrationDate: registrationDate.toIso8601String(),
      isActive: false,
    );

    // putIfAbsent == se não tiver o email cadastrado vai adicionar, senão não.
    _associates.putIfAbsent(email, () => newUser);
    // Fazer login após registrar, pode mudar se quiser seguir outra lógica
    _updateUser(newUser); // Setar o user atual como o que foi criado
  }

  // Simular ativação do usuário após verificação do email
  @override
  Future<void> activateUser() async {
    // _currentUser.isActive = true;
    // _updateUser(user);
  }

  static void _updateUser(AssociateModel? user) {
    _currentUser = user;
    _controller?.add(_currentUser);
  }
}
