import 'package:fast_app_base/data/memory/vo_todo.dart';
import 'package:flutter/cupertino.dart';

/*------Inherited 방버 stateMangement X ---*/
class TodoDataNotifier extends ValueNotifier<List<Todo>>{
  TodoDataNotifier() : super([]);

  void addTodo(Todo todo){
    value.add(todo);
    notifyListeners(); //데이터가 바꿨을때 알려주는 함수
  }

  void notify(){
    notifyListeners();
  }
}