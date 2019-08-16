import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'model/post.dart';

class MyAppPage extends StatefulWidget {
  @override
  _MyAppPageState createState() => _MyAppPageState();
}

class _MyAppPageState extends State<MyAppPage> {
  Firestore firestore = Firestore.instance;

  Stream getDocuments() {
    var ref = firestore.collection('post').where('tags', arrayContains: '플러터');

    return ref.snapshots();
  }

  void updateData(Post post) {
    var docId = post.docId;

    Map<String, dynamic> map = Map();
    map['views'] = post.views + 1;

    firestore.collection('post').document(docId).updateData(map);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: getDocuments(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<DocumentSnapshot> docs = snapshot.data.documents;

              print(docs.length);

              List<Post> posts = [];

              docs.forEach((doc) {
                Map map = doc.data;

                Post post = Post.fromMap(doc.data);
                post.docId = doc.documentID;

                posts.add(post);
              });

              return buildPost(posts);
            } else if (snapshot.hasError) {
              return Text("error ${snapshot.error}");
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }

  ListView buildPost(List<Post> posts) {
    return ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          Post post = posts[index];

          return buildPostItem(post);
        });
  }

  Widget buildPostItem(Post post) {
    return Card(
      child: Column(
        children: <Widget>[
          Text("title ${post.title}"),
          SizedBox(
            height: 3.0,
          ),
          Text("content ${post.content}"),
          Text("조회수  ${post.views}"),
          RaisedButton(
            onPressed: () {

              updateData(post);
            },
            child: Text("업데이트 조회수"),
          )
        ],
      ),
    );
  }
}
