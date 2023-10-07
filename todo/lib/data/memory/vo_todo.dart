import 'package:freezed_annotation/freezed_annotation.dart';

import 'todo_status.dart';

part 'vo_todo.freezed.dart';

@unfreezed
class Todo with _$Todo {
  const factory Todo({
    required final int id,
    required final DateTime createdTime,
    DateTime? modifyTime,
    required String title,
    required DateTime dueDate,
    required TodoStatus status,
  }) = _Todo;
}
