import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<User> get user => _auth.authStateChanges();
  User get currentUser => _auth.currentUser;
  Future<String> signUp(
      {@required String email, @required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return "Success";
    } on FirebaseAuthException catch (e) {
      switch (e.message) {
        case "Given String is empty or null":
          return "Email or password is empty";
          break;
        case "The email address is badly formatted.":
          return "Email is wrong format";
          break;
        case "The email address is already in use by another account.":
          return "Email address is already in use";
          break;
        case "A network error (such as timeout, interrupted connection or unreachable host) has occurred.":
          return "No internet connection";
          break;
        default:
          return e.message;
          break;
      }
    }
  }

  Future<String> signIn(
      {@required String email, @required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return "Success";
    } on FirebaseAuthException catch (e) {
      switch (e.message) {
        case "Given String is empty or null":
          return "Email or password is empty";
          break;
        case "The email address is badly formatted.":
          return "Email is wrong format";
          break;
        case "There is no user record corresponding to this identifier. The user may have been deleted.":
          return "Account with this email doesn't exist";
          break;
        case "The password is invalid or the user does not have a password.":
          return "Wrong password";
          break;
        case "A network error (such as timeout, interrupted connection or unreachable host) has occurred.":
          return "No internet connection";
          break;
        default:
          return e.message;
          break;
      }
    }
  }

  Future<String> signOut() async {
    try {
      await _auth.signOut();
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> forgotPassword({@required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return "Success";
    } on FirebaseAuthException catch (e) {
      switch (e.message) {
        case "Given String is empty or null":
          return "Email is empty";
          break;
        case "The email address is badly formatted.":
          return "Email is wrong format";
          break;
        case "There is no user record corresponding to this identifier. The user may have been deleted.":
          return "Account with this email doesn't exist";
          break;
        case "A network error (such as timeout, interrupted connection or unreachable host) has occurred.":
          return "No internet connection";
          break;
        default:
          return e.message;
          break;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> validatePassword({@required String currentPassword}) async {
    var authCredential = EmailAuthProvider.credential(
      email: currentUser.email,
      password: currentPassword,
    );
    try {
      await currentUser.reauthenticateWithCredential(authCredential);
      return "Success";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "wrong-password":
          return "Wrong password";
          break;
        default:
          return e.message;
          break;
      }
    }
  }

  Future<String> changePassword({@required String newPassword}) async {
    try {
      await _auth.currentUser.updatePassword(newPassword);
      return "Success";
    } on FirebaseAuthException catch (e) {
      switch (e.message) {
        default:
          return e.message;
          break;
      }
    }
  }
}
