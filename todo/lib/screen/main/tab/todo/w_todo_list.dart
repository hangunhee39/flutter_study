import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/data/memory/todo_data_holder.dart';
import 'package:fast_app_base/screen/main/tab/todo/w_todo_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//riverpod2 CounsuerWidget으로 변경
class ToDoList extends ConsumerWidget {
  const ToDoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //riverpod2 observe하기 WidgetRef는 위젯 루트(extends)를 받음
    final todoList = ref.watch(todoDataProvider);

    return todoList.isEmpty
        ? '할일을 작성해보세요.'.text.size(30).makeCentered()
        : Column(
            children: todoList.map((e) => TodoItem(e)).toList(),
          );
  }
}
