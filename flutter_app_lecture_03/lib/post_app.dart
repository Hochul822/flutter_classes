import 'package:flutter/material.dart';
import 'package:flutter_lecture_03/page/post_list_page.dart';

class PostApp extends StatefulWidget {
  @override
  _PostAppState createState() => _PostAppState();
}

class _PostAppState extends State<PostApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: PostListPage(),
        ),
      ),
    );
  }
}

