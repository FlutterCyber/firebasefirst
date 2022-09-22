import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasefirst/pages/add_post.dart';
import 'package:firebasefirst/pages/home_page.dart';
import 'package:firebasefirst/pages/signin_page.dart';
import 'package:firebasefirst/services/preference_service.dart';
import 'package:firebasefirst/signup_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // bir marta accountga kirib sign out qilmagan bolsa keyinga marta
  // kirganda login parol so'ramasligi uchun shu Widget yoziladi

  Widget _startPage() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          Preference.saveUserId(snapshot.data!.uid);
          return HomePage();
        } else {
          //Preference.deleteUserId();
          return SignInPage();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _startPage(),
      routes: {
        HomePage.id: (context) => HomePage(),
        SignUpPage.id: (context) => SignUpPage(),
        SignInPage.id: (context) => SignInPage(),
        AddPostPage.id: (context) => AddPostPage(),
      },
    );
  }
}
