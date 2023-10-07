import 'package:fast_app_base/data/memory/bloc/bloc_status.dart';
import 'package:fast_app_base/data/memory/bloc/todo_bloc_state.dart';
import 'package:fast_app_base/data/memory/todo_status.dart';
import 'package:fast_app_base/screen/dialog/d_confirm.dart';
import 'package:fast_app_base/screen/main/wrute/d_write_todo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'vo_todo.dart';

class TodoCubit extends Cubit<TodoBlocState> {
  TodoCubit()
      : super(const TodoBlocState(
          <Todo>[],
          BlocStatus.initial,
        ));

  /*------Inherited 방버 stateMangement X ---
  const TodoDataHolder({
    super.key,
    required super.child,
    required this.notifier,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  //위젯트리에 있는 모든곳에서 holder를 사용가능하게 : dependOnInheritedWigetOfExactType
  static TodoDataHolder of(BuildContext context) {
    TodoDataHolder inherited = (context.dependOnInheritedWidgetOfExactType<
        TodoDataHolder>())!;
    return inherited;
  }
   */

  void addTodo() async {
    final result = await WriteTodoDialog().show();
    if (result != null) {
      final copiedDldToDoList = List.of(state.todoList);
      copiedDldToDoList.add(Todo(
        id: DateTime.now().millisecondsSinceEpoch,
        title: result.text,
        dueDate: result.dateTime,
        createdTime: DateTime.now(),
        status: TodoStatus.incomplete
      ));
      emit(state.copyWith(todoList: copiedDldToDoList));
    }
  }

  void changeTodoStatus(Todo todo) async {
    final copiedOldTodoList = List.of(state.todoList);
    final todoIndex =
        copiedOldTodoList.indexWhere((element) => element.id == todo.id);

    TodoStatus status = todo.status;
    switch (todo.status) {
      case TodoStatus.incomplete:
        status = TodoStatus.ongoing;
      case TodoStatus.ongoing:
        status = TodoStatus.complete;
      case TodoStatus.complete:
        final result = await ConfirmDialog('정말로 처음 상태로 변경하시겠어요?').show();
        result?.runIfSuccess((data) {
          status = TodoStatus.incomplete;
        });
    }
    //notifier.notify();
    //todoList.refresh();
    copiedOldTodoList[todoIndex] = todo.copyWith(status: status);
    emit(state.copyWith(todoList: copiedOldTodoList));
  }

  void editTodo(Todo todo) async {
    final result = await WriteTodoDialog(todoForEdit: todo).show();
    if (result != null) {
      todo.title = result.text;
      todo.dueDate = result.dateTime;

      final oldCopiedList = List<Todo>.from(state.todoList);
      oldCopiedList[oldCopiedList.indexOf(todo)] = todo;
      emit(state.copyWith(todoList: oldCopiedList));
    }
  }

  void removeTodo(Todo todo) {
    final oldCopiedList = state.todoList;
    oldCopiedList.removeWhere((element) => element.id == todo.id);

    emit(state.copyWith(todoList: oldCopiedList));
  }
}

// mixin class TodoDataProvider {
//   late final TodoDataHolder todoData = Get.find();
// }
