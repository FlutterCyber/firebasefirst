import 'dart:io';

import 'package:firebasefirst/model/post_model.dart';
import 'package:firebasefirst/pages/home_page.dart';
import 'package:firebasefirst/services/RTDB_service.dart';
import 'package:firebasefirst/services/preference_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/store_service.dart';

class AddPostPage extends StatefulWidget {
  static const String id = "add_post_page";

  const AddPostPage({Key? key}) : super(key: key);

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  bool isLoading = false;

  // rasmni pick qilish uchun o'zgaruvchilar
  File? _image;
  final picker = ImagePicker();

  var nameController = TextEditingController();
  var surnameController = TextEditingController();

  Future _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No image selected");
      }
    });
  }

  _addPost() async {
    String name1 = nameController.text.toString();
    String surname1 = surnameController.text.toString();
    if (name1.isNotEmpty && surname1.isNotEmpty) {
      uploadImage(name1, surname1);
    }
  }

  void uploadImage(String name, String surname) {
    setState(() {
      isLoading = true;
    });

    StoreService.uploadImage(_image!).then((imgUrl) => {
          _addToRealtimeDatabase(name: name, surname: surname, imgUrl: imgUrl!),
        });
  }

  _addToRealtimeDatabase(
      {required String name,
      required String surname,
      required String imgUrl}) async {
    String? userId = await Preference.getUserId();
    Post post1 =
        Post(userId: userId!, name: name, surname: surname, img_url: imgUrl);

    RTDB.addPost(post1).then((value) => {
          setState(() {
            isLoading = false;
          }),
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      _getImage();
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      child: _image != null
                          ? Image.file(
                              _image!,
                              fit: BoxFit.cover,
                            )
                          : Image.asset('assets/images/img.png'),
                    ),
                  ),
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
          isLoading
              ? Container(
            color: Colors.black26,

                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
