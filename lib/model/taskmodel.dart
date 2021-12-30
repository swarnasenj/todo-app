class Todo {
  String todo;
  DateTime date;
  String priority;
  bool checked;

  Todo({
    required this.todo,
    required this.date,
    required this.priority,
    required this.checked,
  });
  Todo.fromMap(Map map)
      : this.todo = map['todo'],
        date = map['date'],
        this.priority = map['priority'],
        this.checked = map['checked'];

  Map toMap() {
    return {
      'todo':this.todo,
      'date':this.date,
      'priority':this.priority,
      'checked':this.checked,
    };
  }
}
