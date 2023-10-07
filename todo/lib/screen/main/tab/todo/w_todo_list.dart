import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/data/preference/app_preferences.dart';
import 'package:fast_app_base/data/memory/todo_data_holder.dart';
import 'package:fast_app_base/screen/main/tab/todo/w_todo_item.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

//getX 를 사용하는 방법 2 : GetView<> - Obx로 감싸야함 (추천 X)
//getX 를 사용하는 방법 3 : GetBuilder<>
class ToDoList extends StatelessWidget with TodoDataProvider{
  ToDoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
      todoData.todoList.isEmpty
        ? '할일을 작성해보세요.'.text.size(30).makeCentered()
        : Column(
    children: todoData.todoList.map((e) => TodoItem(e)).toList(),
    ));

    // ValueListenableBuilder(
    //   valueListenable: TodoDataHolder.of(context).notifier,
    //   builder: (context, todoList, child) {
    //     return todoList.isEmpty
    //         ? '할일을 작성해보세요.'.text.size(30).makeCentered()
    //         : Column(
    //             children: todoList.map((e) => TodoItem(e)).toList(),
    //           );
    //   },
    // );
  }
}
