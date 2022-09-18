import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasefirst/pages/signin_page.dart';
import 'package:firebasefirst/services/preference_service.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;

  static Future<User?> signUpUser(
      BuildContext context, String name, String email, String password) async {
    try {
      var authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = authResult.user;
      print("USER MA'LUMOTLARI: ${user.toString()}");
      return user;
    } catch (e) {
      print("ERRORNI KO'RSAT: ${e.toString()}");
    }
  }

  static Future<User?> signInUser(
      BuildContext context, String email, String password) async {
    try {
      _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = await _auth.currentUser;
      print("USER MA'LUMOTLARI: ${user.toString()}");
      return user;
    } catch (e) {
      print("ERRORNI KO'RSAT: ${e.toString()}");
    }
  }

  static void signOutUser(BuildContext context) {
    _auth.signOut();
    Preference.deleteUserId().then((value) => {
          Navigator.pushReplacementNamed(context, SignInPage.id),
        });
  }
}
