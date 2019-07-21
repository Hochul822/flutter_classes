import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/post.dart';

class PostBoardScreen extends StatefulWidget {
  @override
  _PostBoardScreenState createState() => _PostBoardScreenState();
}

class _PostBoardScreenState extends State<PostBoardScreen> {
  Firestore fireStore = Firestore.instance;

  @override
  void initState() {
    super.initState();
  }

  Stream getDocument() {
    CollectionReference ref = fireStore.collection('post');
    return ref.snapshots();
  }

  void updateViews(Post post) {
    fireStore
        .collection('post')
        .document(post.id)
        .updateData({'views': post.views + 1});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("글 목록 앱"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text(
              "글 목록",
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            StreamBuilder(
              stream: getDocument(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List<DocumentSnapshot> data = snapshot.data.documents;

                  List<Post> posts = [];
                  data.forEach((DocumentSnapshot doc) {
                  
                    Post post = Post.fromJson(doc.data);
                    post.id = doc.documentID;

                    posts.add(post);
                  });

                  return Flexible(
                    child: ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (BuildContext context, int index) {
                          Post post = posts[index];

                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 14.0),
                            child: Column(
                              children: <Widget>[
                                Text("title ${post.title}"),
                                Text("content ${post.content}"),
                                RaisedButton(onPressed: (){
                                  updateViews(post);
                                }, child: Text("조회수 올리기"),)
                              ],
                            ),
                          );
                        }),
                  );
                } else if (snapshot.hasError) {
                  return Text("error ${snapshot.error}");
                } else {
                  return CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}