import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/data/memory/todo_data_holder.dart';
import 'package:fast_app_base/screen/main/tab/todo/w_todo_item.dart';
import 'package:flutter/material.dart';

class ToDoList extends StatelessWidget {
  const ToDoList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: TodoDataHolder.of(context).notifier,
      builder: (context, todoList, child) {
        return todoList.isEmpty
            ? '할일을 작성해보세요.'.text.size(30).makeCentered()
            : Column(
                children: todoList.map((e) => TodoItem(e)).toList(),
              );
      },
    );
  }
}
