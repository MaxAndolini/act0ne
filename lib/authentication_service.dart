import 'package:act0ne/begin.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<int> signIn({scaffold, String email, String password}) async {
    try {
      if (email.isEmpty || !EmailValidator.validate(email)) {
        scaffold.currentState.showSnackBar(
          new SnackBar(
            content: new Text('Invalid e-mail!'),
          ),
        );
        return 0;
      }

      if (password.isEmpty && password.length < 4) {
        scaffold.currentState.showSnackBar(
          new SnackBar(
            content: new Text('Invalid password!'),
          ),
        );
        return 0;
      }

      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      Navigator.push(
        scaffold,
        MaterialPageRoute(builder: (context) => Begin()),
      );
      return 1;
    } on FirebaseAuthException catch (error) {
      scaffold.currentState.showSnackBar(
        new SnackBar(
          content: new Text(error.message),
        ),
      );
      return 0;
    }
  }

  Future<String> signUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Signed Up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
