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

  _addPost(){
    String name = nameController.text.toString();
    String surname = surnameController.text.toString();







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
