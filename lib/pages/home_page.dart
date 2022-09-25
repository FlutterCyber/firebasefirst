import 'package:firebasefirst/pages/add_post_page.dart';
import 'package:firebasefirst/services/RTDB_service.dart';
import 'package:firebasefirst/services/auth_service.dart';
import 'package:firebasefirst/services/preference_service.dart';
import 'package:flutter/material.dart';

import '../model/post_model.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> item = [];

  //Post post = new Post(userId: "12345", name: "Muhammad1", surname: "Togoyev1");

  @override
  void initState() {
    super.initState();

    _apiGetPosts();
  }

  _apiGetPosts() async {
    String? userId = await Preference.getUserId();
    RTDB.getPosts(userId!).then((posts) => {
          setState(() {
            item.addAll(posts);
          }),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
        actions: [
          IconButton(
            onPressed: () {
              AuthService.signOutUser(context);
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: item.length,
          itemBuilder: (ctx, i) {
            return itemOfList(item[i]);
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.pushReplacementNamed(context, AddPostPage.id);
        },
      ),
    );
  }

  Widget itemOfList(Post post) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            post.surname,
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}
