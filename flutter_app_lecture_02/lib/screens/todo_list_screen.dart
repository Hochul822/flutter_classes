import 'package:flutter/material.dart';
import 'package:flutter_app_lecture_02/database/db.dart';
import 'package:flutter_app_lecture_02/model/todo.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<ToDo> todos = [];
  DB db = DB();
  TextEditingController textCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  @override
  void dispose() {
    super.dispose();
    db.close();
  }

  initDatabase() async {
    await db.getDB();

    await readDatabase();
  }

  readDatabase() async {
    List<Map> maps = await db.select();

    List<ToDo> todos = [];

    for (Map map in maps) {
      todos.add(ToDo.fromMap(map));
    }

    setState(() {
      this.todos = todos;
    });
  }

  Widget todosView() {
    return Flexible(
      child: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          ToDo todo = todos[index];

          return Dismissible(
            onDismissed: (DismissDirection direction) {
              print(direction);
              db.delete(todo.id);
              setState(() {
                todos.removeAt(index);
              });
            },
            key: Key("${todo.id}"),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
              child: Card(
                elevation: 0.1,
                child: Center(
                  child: Row(
                    children: <Widget>[
                      Text("${todo.id}"),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text("${todo.title}")
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  addTodo(String text) async {
    await db.insert(text);
    readDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("기록 앱"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text("memo"),
            todosView(),
            Container(
              margin: const EdgeInsets.only(bottom: 32.0),
              child: TextField(
                controller: textCtrl,
                decoration: InputDecoration(border: OutlineInputBorder(borderSide: BorderSide(color: Colors.green))),
                onSubmitted: (String text) {
                  print(text);
                  addTodo(text);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
