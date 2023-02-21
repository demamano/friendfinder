import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friendfinder/feature/auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';

import '../../../models/user_model.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository, ref: ref);
});
final userDataAuthProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.getUserData();
});

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;

  AuthController({required this.ref, required this.authRepository});
  Future<UserModel?> getUserData() async {
    UserModel? user = await authRepository.getCurrentUserData();
    return user;
  }

  Future<String> signUp(
      String email, String password, BuildContext context) async {
    String result = await authRepository.signUpUser(
      email: email,
      password: password,
      context: context,
    );
    return result;
  }

  Future<String> saveUser(
    String fullName,
    String fieldOfStudy,
    File file,
    BuildContext context,
    String interests,
  ) async {
    String result = await authRepository.saveUserDataToDatabase(
        fullName: fullName,
        fieldOfStudy: fieldOfStudy,
        file: file,
        context: context,
        ref: ref,
        interests: interests);
    return result;
  }

  Future<String> signInWithEmail(
      String email, String password, BuildContext context) async {
    String result = await authRepository.loginUser(
        email: email, password: password, context: context);
    return result;
  }
}
