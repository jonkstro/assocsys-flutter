import 'dart:io';

import 'package:assocsys/core/models/associate_model.dart';
import 'package:assocsys/core/services/auth/auth_firebase_service.dart';
import 'package:assocsys/core/services/auth/auth_mock_service.dart';

abstract class AuthService {
  AssociateModel? get currentUser;
  Stream<AssociateModel?> get userChanges;

  Future<void> signup(
    String name,
    String email,
    String password,
    File? image,
    String registrationNumber,
    DateTime birthDate,
    DateTime registrationDate,
  );
  Future<void> login(
    String email,
    String password,
  );
  Future<void> logout();

  Future<void> activateUser();

  factory AuthService() {
    // return AuthMockService();
    return AuthFirebaseService();
  }
}
