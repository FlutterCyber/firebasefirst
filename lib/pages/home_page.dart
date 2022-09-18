import 'package:firebasefirst/services/auth_service.dart';
import 'package:firebasefirst/signup_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, SignUpPage.id);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Center(
        child: Container(
          height: 45,
          width:200,
          color: Colors.blue,
          child: Center(
            child: TextButton(
              onPressed: () {
                AuthService.signOutUser(context);
              },
              child: Text(
                "Log out",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
