import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friendfinder/feature/storage_methods.dart';
import '../../../models/user_model.dart';
import '../../../utils/showSnackBar.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepository({
    required this.auth,
    required this.firestore,
  });
  // Future<UserModel> getUserDetails() async {
  //   User currentUser = auth.currentUser!;
  //   DocumentSnapshot documentSnapshot =
  //       await firestore.collection("users").doc(currentUser.uid).get();
  //   return UserModel.fromSnap(documentSnapshot);
  // }
  Future<UserModel?> getCurrentUserData() async {
    var userData =
        await firestore.collection("users").doc(auth.currentUser?.uid).get();
    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }
    return user;
  }

  Future<String> signUpUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    String res = "error occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await auth.createUserWithEmailAndPassword(
            email: email, password: password);

        res = "success";
      } else {
        res = "failed to succed";
      }
    } on FirebaseAuthException catch (e) {
      String value = e.code;

      switch (value) {
        case "user-not-found":
          showSnackBar(context, "user not found");
          break;
        case "weak-password":
          showSnackBar(context, "user not found");
          break;
        case "email-already-in-use":
          showSnackBar(context, "email already in use");
          break;
        case "invalid-email":
          showSnackBar(context, "invalid email");
          break;
        case "operation-not-allowed":
          showSnackBar(context, "operation not allowed");
      }
    }
    return res;
  }

  Future<String> saveUserDataToDatabase(
      {required String fullName,
      required String fieldOfStudy,
      required File file,
      required BuildContext context,
      required String interests,
      required ProviderRef ref}) async {
    String result = "error occured";
    try {
      String uid = auth.currentUser!.uid;
      String photoUrl = await ref
          .read(storageMethodsProvider)
          .uploadImageToStorage('profilePic$uid/', file);
      UserModel user = UserModel(
        uid: auth.currentUser!.uid,
        photoUrl: photoUrl,
        fullName: fullName,
        groupId: [],
        isOnline: true,
        interests: interests,
        fieldOfStudy: fieldOfStudy,
      );
      await firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .set(user.toMap());
      result = "success";
    } on FirebaseException catch (e) {
      // print(e.code);
      showSnackBar(context, e.toString());
    }
    return result;
  }

  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      auth.currentUser!.sendEmailVerification();
      showSnackBar(context, 'Email Verification sent!');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
    throw {};
  }

  Future<String> loginUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    String result = "some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in with password and email
        await auth.signInWithEmailAndPassword(email: email, password: password);
        result = "success";
      } else {
        showSnackBar(context, "please fill required fields");
      }
    } on FirebaseException catch (err) {
      // print('ocurred error is ${err.message}');

      if (err.code == "user-not-found") {
        showSnackBar(context, "user not found");
      } else if (err.code == "wrong-password") {
        showSnackBar(context, "wrong password");
      }
      // wrong-password

    }
    return result;
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}

      // await _firestore.collection('users').doc(credential.user!.uid).set({
        //   'username': username,
        //   'email': email,
        //   'fullName': fullName,
        //   'uid': credential.user!.uid,
        //   'photoUrl': photoUrl
        // });
        // another way without accessing uid is
        // _firestore.collection('users').add(data) instead of set method
  

// on FirebaseAuthException catch (e) {
    //   // showSnackBar(context, e.message!);
    //   if (e.code == 'invalid-email') {
    //     res = 'email is badly formatted';
    //   } else if (e.code == 'weak-password') {
    //     res = 'your password should be at least six characters';
    //   }