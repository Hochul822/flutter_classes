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

  Stream<QuerySnapshot> getDocument() {
    CollectionReference ref = fireStore.collection('post').where('views', isGreaterThan: 30).orderBy('views', descending: true);

    return ref.snapshots();
  }

  Stream getDocumentByOrder() {
    var ref = fireStore.collection('post').orderBy('title', descending: false);

    return ref.snapshots();
  }

  Stream getDocumentByLimit() {
    var ref = fireStore.collection('post').orderBy('title', descending: true).limit(3);
    return ref.snapshots();
  }

  Stream getDocumentByWhere() {
    var ref = fireStore.collection('post')
        .where('views', isGreaterThan: 10)
        .orderBy('views', descending: false);

    return ref.snapshots();
  }


  void updateViews(Post post) {
    fireStore
        .collection('post')
        .document(post.docId)
        .updateData({'views': post.views + 1});
  }
  
  void queryWhere() {
    //fireStore.collection('post').where('views', isGreaterThan: {'views': 2}).snapshots();
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
                  
                    Post post = Post.fromMap(doc.data);
                    post.docId = doc.documentID;

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