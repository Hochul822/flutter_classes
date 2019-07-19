class ToDo {
  int id;
  String title;

  ToDo(this.id, this.title);

  ToDo.fromMap(Map map)
      : this.id = map['id'],
        this.title = map['title'];

  List<ToDo> fromList(List<Map<String, dynamic>> query) {
    List<ToDo> todos = [];

    for (Map map in query) {
      todos.add(ToDo.fromMap(map));
    }

    return todos;
  }
}
