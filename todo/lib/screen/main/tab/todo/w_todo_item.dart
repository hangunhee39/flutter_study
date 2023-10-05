import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/dart/extension/datetime_extension.dart';
import 'package:fast_app_base/common/widget/w_rounded_container.dart';
import 'package:fast_app_base/data/memory/todo_data_holder.dart';
import 'package:fast_app_base/data/memory/vo_todo.dart';
import 'package:flutter/material.dart';

import 'w_todo_status.dart';

class TodoItem extends StatelessWidget with TodoDataProvider {
  final Todo todo;

  TodoItem(this.todo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dismissible( //swap 로 item 사라지게
      onDismissed: (direction){
        todoData.removeTodo(todo);
      },
      //기본적으로는 그냥 secondaryBG 가 있으면 오른쪽으로 밀었을 때
      background: RoundedContainer(
        color: context.appColors.removeTodoBg,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            width20,
            Icon(
              EvaIcons.trash2Outline,
              color: Colors.white,
            ),
            width20,
          ],
        ),
      ),
      //왼쪽으로 밀었을때 background
      secondaryBackground:RoundedContainer(
        color: context.appColors.removeTodoBg,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              EvaIcons.trash2Outline,
              color: Colors.white,
            ),
            width20,
          ],
        ),
      ),
      key: ValueKey(todo.id),
      child: RoundedContainer(
        margin: const EdgeInsets.only(bottom: 6),
        color: context.appColors.itemBackground,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            todo.dueDate?.relativeDays.text.make() ?? "".text.make(),
            Row(
              children: [
                TodoStatusWidget(todo),
                Expanded(child: todo.title.text.size(20).medium.make()),
                IconButton(
                    onPressed: () async {
                      todoData.editTodo(todo);
                    },
                    icon: const Icon(EvaIcons.editOutline))
              ],
            )
          ],
        ).pOnly(top: 15, right: 16, left: 5, bottom: 10),
      ),
    );
  }
}
