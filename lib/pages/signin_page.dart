import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasefirst/pages/home_page.dart';
import 'package:firebasefirst/services/auth_service.dart';
import 'package:firebasefirst/services/preference_service.dart';
import 'package:flutter/material.dart';

import '../signup_page.dart';

class SignInPage extends StatefulWidget {
  static const String id = "sign_in_page";

  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  _doSignIn() async {
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      await AuthService.signInUser(context, email, password)
          .then((firebaseUser) => {
                _getFirebaseUser(firebaseUser!),
              });
    }
  }

  _getFirebaseUser(User firebaseUser) async {
    if (firebaseUser != null) {
      await Preference.saveUserId(firebaseUser.uid);
      Navigator.pushReplacementNamed(context, HomePage.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              color: Colors.blue,
              height: 45,
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  _doSignIn();
                },
                child: Text(
                  "Sign in",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 45,
              child: TextButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, SignUpPage.id);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
