import 'dart:io';

import 'package:assocsys/core/models/associate_model.dart';
import 'package:assocsys/core/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthFirebaseService implements AuthService {
  static AssociateModel? _currentUser;
  static final _userStream = Stream<AssociateModel?>.multi((control) async {
    final authChanges = FirebaseAuth.instance.authStateChanges();
    await for (final user in authChanges) {
      _currentUser = user == null ? null : await _toAssociate(user);
      control.add(_currentUser);
    }
  });

  @override
  AssociateModel? get currentUser => _currentUser;

  @override
  Stream<AssociateModel?> get userChanges => _userStream;

  @override
  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
      // TODO: Adicionar sharedpreferences pra poder continuar ou não logado.
    );
  }

  @override
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> signup(
      String name,
      String email,
      String password,
      File? image,
      String registrationNumber,
      DateTime birthDate,
      DateTime registrationDate) async {
    // Inicializa o Firebase com um nome específico ('userSignup') e utiliza as opções da
    // instância Firebase padrão
    final signup = await Firebase.initializeApp(
      name: 'userSignup',
      options: Firebase.app().options,
    );
    // Obtém uma instância do serviço de autenticação do Firebase para a instância inicializada
    // anteriormente (signup - FirebaseApp).
    final auth = FirebaseAuth.instanceFor(app: signup);
    UserCredential credential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (credential.user != null) {
      // 1. Upload da foto do usuário
      final imageName = '${credential.user!.uid}.jpg';
      final imageUrl = await _uploadUserImage(image, imageName);

      // 2. atualizar os atributos do usuário
      await credential.user?.updateDisplayName(name);
      await credential.user?.updatePhotoURL(imageUrl);

      // 2.5 fazer o login do usuário, pode deixar comentado se quiser
      await login(email, password);

      // 3. salvar usuário no banco de dados (opcional)
      // Vamos passar o nome e foto por parametro para exibir corretamente nome e foto
      _currentUser = await _toAssociate(
        credential.user!,
        name,
        imageUrl,
        registrationNumber,
        birthDate.toIso8601String(),
        registrationDate.toIso8601String(),
      );
      await _saveAssociateOnDb(_currentUser!);
    }
    // Remove a instância Firebase inicializada anteriormente para liberar recursos.
    await signup.delete();
  }

  @override
  Future<void> activateUser(AssociateModel user) {
    throw UnimplementedError();
  }

  static Future<AssociateModel> _toAssociate(
    User user, [
    String? name,
    String? imageUrl,
    String? registrationNumber,
    String? birthDate,
    String? registrationDate,
  ]) async {
    final userFromDb = await _getAssociateFromDb(user.uid);

    return AssociateModel(
      id: user.uid,
      name: name ??
          user.displayName ??
          userFromDb?.name ??
          user.email!.split('@')[0],
      registrationNumber:
          userFromDb?.registrationDate ?? registrationNumber ?? '',
      birthDate: userFromDb?.birthDate ?? birthDate ?? '',
      email: user.email!,
      imageUrl: userFromDb?.imageUrl ??
          imageUrl ??
          user.photoURL ??
          'assets/images/avatar.png',
      registrationDate: userFromDb?.registrationDate ?? registrationDate ?? '',
      isActive: user.emailVerified,
    );
  }

  Future<String?> _uploadUserImage(File? image, String imageName) async {
    if (image == null) return null;
    // Referenciar o storage
    final storage = FirebaseStorage.instance;
    // O caminho que vai salvar a imagem
    final imageRef = storage.ref().child('user_images').child(imageName);
    await imageRef.putFile(image).whenComplete(() {});
    // Retornar o Future de String da URL da imagem
    return await imageRef.getDownloadURL();
  }

  /// ----------- FIRESTORE INICIO ------------
  static Future<void> _saveAssociateOnDb(AssociateModel user) async {
    // definir a instancia do firestore
    final store = FirebaseFirestore.instance;
    // definir o id do documento que vai salvar e nome da "tabela"
    final docRef = store.collection('users').doc(user.id);

    return docRef.set({
      'name': user.name,
      'email': user.email,
      'imageUrl': user.imageUrl,
      'birthDate': user.birthDate,
      'registrationNumber': user.registrationNumber,
      'registrationDate': user.registrationDate,
    });
  }

  static Future<AssociateModel?> _getAssociateFromDb(String uid) async {
    final store = FirebaseFirestore.instance;
    final docRef = store.collection('users').doc(uid);
    final doc = await docRef.get();
    final data = doc.data();
    if (data == null) return null;
    return AssociateModel(
      id: doc.id,
      name: data['name'],
      registrationNumber: data['registrationNumber'],
      birthDate: data['birthDate'],
      email: data['email'],
      imageUrl: data['imageUrl'],
      registrationDate: data['registrationDate'],
      isActive: false,
    );
  }

  /// ----------- FIRESTORE FIM ------------
}
