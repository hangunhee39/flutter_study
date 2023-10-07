import 'todo_status.dart';

class Todo {
  Todo({
    required this.id,
    required this.title,
    required this.dueDate,
    this.status = TodoStatus.incomplete,
  }) : createdTime = DateTime.now(); //createdTime은 생성자가 만들어질때 변수에 따로 할당

  int id;
  String title;
  final DateTime createdTime;
  DateTime? modifyTime;
  DateTime? dueDate;
  TodoStatus status;
}
