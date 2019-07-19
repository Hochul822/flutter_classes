import 'package:flutter/material.dart';
import 'package:flutter_app_lecture_02/screens/todo_list_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TodoListScreen(),
    );
  }
}
