import 'package:firebasefirst/model/post_model.dart';
import 'package:firebasefirst/pages/home_page.dart';
import 'package:firebasefirst/services/RTDB_service.dart';
import 'package:firebasefirst/services/preference_service.dart';
import 'package:flutter/material.dart';

class AddPostPage extends StatefulWidget {
  static const String id = "add_post_page";

  const AddPostPage({Key? key}) : super(key: key);

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  var nameController = TextEditingController();
  var surnameController = TextEditingController();

  _addPost() async {
    String name1 = nameController.text.toString();
    String surname1 = surnameController.text.toString();

    String? userId = await Preference.getUserId();
    Post post1 = new Post(userId: userId!, name: name1, surname: surname1);

    RTDB.addPost(post1).then((value) => {
    Navigator.pushReplacementNamed(context, HomePage.id),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Add post"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Name',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: surnameController,
                decoration: InputDecoration(
                  hintText: 'Surname',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                  width: double.infinity,
                  height: 45,
                  color: Colors.green,
                  child: TextButton(
                    onPressed: () {
                      _addPost();
                    },
                    child: Text(
                      "Add",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
