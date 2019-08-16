import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lecture_03/model/post3.dart';

class PostListPage extends StatefulWidget {
  @override
  _PostListPageState createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  Firestore firestore = Firestore.instance;

  Stream getDocuments() {
    var ref = firestore.collection('post').limit(4);

    return ref.snapshots();
  }

  void updateData(String docId, Post post) {
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

                Post post = Post.fromMap(map);
                post.docId = doc.documentID;

                posts.add(post);
              });

              return buildPostList(posts);
            } else if (snapshot.hasError) {
              return Text("error - ${snapshot.error}");
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }

  Widget buildPostList(List<Post> posts) {
    return ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          Post p = posts[index];

          return GestureDetector(
            onTap: () {

              updateData(p.docId, p);

            },
            child: Card(
              child: Column(
                children: <Widget>[
                  Text('title - ${p.title}'),
                  Text('content - ${p.content}'),
                  Text('views - ${p.views}'),
                ],
              ),
            ),
          );

        });
  }
}
