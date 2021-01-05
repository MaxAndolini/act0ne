import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<int> signIn(
      {scaffold, aContext, String email, String password}) async {
    if (email.isEmpty || !EmailValidator.validate(email)) {
      scaffold.showSnackBar(
        new SnackBar(
          content: new Text('Invalid e-mail!'),
        ),
      );
      return 0;
    }

    if (password.isEmpty || password.length < 6) {
      scaffold.showSnackBar(
        new SnackBar(
          content: new Text('Invalid password!'),
        ),
      );
      return 0;
    }

    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      Navigator.pushReplacementNamed(aContext, "/begin");
      return 1;
    } on FirebaseAuthException catch (error) {
      scaffold.showSnackBar(
        new SnackBar(
          content: new Text(error.message),
        ),
      );
      return 0;
    }
  }

  Future<int> signUp(
      {scaffold,
      aContext,
      String email,
      String password,
      String password2}) async {
    if (email.isEmpty || !EmailValidator.validate(email)) {
      scaffold.showSnackBar(
        new SnackBar(
          content: new Text('Invalid e-mail!'),
        ),
      );
      return 0;
    }

    if ((password.isEmpty || password.length < 6) ||
        (password2.isEmpty || password2.length < 6)) {
      scaffold.showSnackBar(
        new SnackBar(
          content: new Text('Invalid password!'),
        ),
      );
      return 0;
    }

    if (password != password2) {
      scaffold.showSnackBar(
        new SnackBar(
          content: new Text('Passwords are not the same!'),
        ),
      );
      return 0;
    }

    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      Navigator.pushReplacementNamed(aContext, "/signin");
      return 1;
    } on FirebaseAuthException catch (error) {
      scaffold.showSnackBar(
        new SnackBar(
          content: new Text(error.message),
        ),
      );
      return 0;
    }
  }

  Future<void> signOut(aContext) async {
    await _firebaseAuth.signOut();
    Navigator.pushReplacementNamed(aContext, "/signin");
  }
}
