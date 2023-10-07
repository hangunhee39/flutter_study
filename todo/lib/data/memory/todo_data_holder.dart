import 'package:fast_app_base/data/memory/todo_status.dart';
import 'package:fast_app_base/screen/dialog/d_confirm.dart';
import 'package:fast_app_base/screen/main/wrute/d_write_todo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'vo_todo.dart';

//로그아웃 기능
final userProvider = FutureProvider<String>((ref) => 'abc');
//riverpod1 전역변수로 provider 생성
final todoDataProvider = StateNotifierProvider<TodoDataHolder, List<Todo>>((ref) {
  //provider 끼리 연결할 수 있음
  final userId = ref.watch(userProvider);
  debugPrint(userId.value);
  return TodoDataHolder();
});

class TodoDataHolder extends StateNotifier<List<Todo>> {

  TodoDataHolder() :super([]);

  void changeTodoStatus(Todo todo) async {
    switch (todo.status) {
      case TodoStatus.incomplete:
        todo.status = TodoStatus.ongoing;
      case TodoStatus.ongoing:
        todo.status = TodoStatus.complete;
      case TodoStatus.complete:
        final result = await ConfirmDialog('정말로 처음 상태로 변경하시겠어요?').show();
        result?.runIfSuccess((data) {
          todo.status = TodoStatus.incomplete;
        });
    }
    //State는 stateNotifierProveider의 제네릭
    state = List.of(state); //리프레쉬 기능
  }

  void editTodo(Todo todo) async {
    final result = await WriteTodoDialog(todoForEdit: todo).show();
    if (result != null) {
      todo.title = result.text;
      todo.dueDate = result.dateTime;
      state = List.of(state);
    }
  }

  void addTodo() async {
    final result = await WriteTodoDialog().show();
    if (result != null) {
      state.add(Todo(
        id: DateTime
            .now()
            .millisecondsSinceEpoch,
        title: result.text,
        dueDate: result.dateTime,
      ));

      state = List.of(state);
    }
  }

  void removeTodo(Todo todo) {
    state.remove(todo);
    state =List.of(state);
  }
}

extension TodoListHolderProverder on WidgetRef {
  TodoDataHolder get readTodoHolder => read(todoDataProvider.notifier);
}
