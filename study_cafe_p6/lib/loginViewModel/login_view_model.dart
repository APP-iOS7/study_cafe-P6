import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginViewModel {
  var emailController = TextEditingController();
  var pwController = TextEditingController();

  Future<UserCredential?> signIn() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: pwController.text,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {}
    }
    return null;
  }

  void signUp() {}

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
}
