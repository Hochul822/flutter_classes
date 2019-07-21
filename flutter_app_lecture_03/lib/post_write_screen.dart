import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lecture_03/model/post.dart';

class PostWriteScreen extends StatefulWidget {
  @override
  _PostWriteScreenState createState() => _PostWriteScreenState();
}

class _PostWriteScreenState extends State<PostWriteScreen> {
  Firestore firestore = Firestore.instance;
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController contentCtrl = TextEditingController();

  void onSubmitPost() async {
    String title = titleCtrl.text;
    String content = contentCtrl.text;

    Post post = Post(title: title, content: content, views: 0);

    CollectionReference postRef = firestore.collection('post');
    var result = await postRef.add(post.toMap());

    titleCtrl.clear();
    contentCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("글쓰기 페이지"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("글쓰기 페이지", style: TextStyle(color: Colors.blueGrey, fontSize: 24.0),),
            SizedBox(height: 8.0,),
            TextField(
              controller: titleCtrl,
              decoration: InputDecoration(
                  icon:
                      Icon(Icons.event_busy, size: 32, color: Colors.lightBlue),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigoAccent),
                  )),
            ),
            SizedBox(height: 8.0,),
            TextFormField(
              controller: contentCtrl,
              decoration: InputDecoration(
                icon: Icon(Icons.import_contacts, size: 32, color: Colors.lightBlue),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0),
                  borderSide: BorderSide(color: Colors.lime),
                ),
              ),
            ),
            RaisedButton(onPressed: onSubmitPost, child: Text("글 올리기", style: TextStyle(fontSize: 15.0, color: Colors.white),), color: Colors.deepOrange, ),
          ],
        ),
      ),
    );
  }
}