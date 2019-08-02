import 'package:flutter/material.dart';
import 'package:flutter_lecture_03/auth_screen.dart';
import 'package:flutter_lecture_03/platform_screen.dart';
import 'package:flutter_lecture_03/post_write_screen.dart';
import 'post_board_screen.dart';

void main() {
  runApp(MyApp());

  //runApp(AuthApp());
  //runApp(PlatformScreen());
}

class AuthApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthScreen(),
    );
  }
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: "Home Page",),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void openBoardScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PostBoardScreen()),
    );
  }

  void openPostWriteScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PostWriteScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: openBoardScreen,
              child: Text("글 목록", style: TextStyle(color: Colors.white),),
              color: Colors.pinkAccent,
            ),
            RaisedButton(
              onPressed: openPostWriteScreen,
              child: Text("글 쓰기", style: TextStyle(color: Colors.white),),
              color: Colors.pinkAccent[200],
            ),
          ],
        ),
      ),
    );
  }
}