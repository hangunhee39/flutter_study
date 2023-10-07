import 'package:after_layout/after_layout.dart';
import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/dart/extension/datetime_extension.dart';
import 'package:fast_app_base/common/widget/scaffold/bottom_dialog_scaffold.dart';
import 'package:fast_app_base/common/widget/w_round_button.dart';
import 'package:fast_app_base/common/widget/w_rounded_container.dart';
import 'package:fast_app_base/data/memory/vo_todo.dart';
import 'package:fast_app_base/screen/main/wrute/vo_write_to_result.dart';
import 'package:flutter/material.dart';
import 'package:nav/dialog/dialog.dart';

import '../../../common/util/app_keyboard_util.dart';

class WriteTodoDialog extends DialogWidget<WriteTodoResult> {
  final Todo? todoForEdit;

  WriteTodoDialog({this.todoForEdit, super.key});

  @override
  DialogState<WriteTodoDialog> createState() => _WriteTodoDialogState();
}

class _WriteTodoDialogState extends DialogState<WriteTodoDialog>
    with AfterLayoutMixin {
  DateTime _selectedDate = DateTime.now();
  final textController = TextEditingController();
  final node = FocusNode();

  @override
  void initState() {
    if (widget.todoForEdit != null) {
      _selectedDate = widget.todoForEdit!.dueDate!;
      textController.text = widget.todoForEdit!.title;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomDialogScaffold(
        body: RoundedContainer(
      child: Column(
        children: [
          Row(
            children: [
              '할 일을 작성해주세요.'.text.size(18).bold.make(),
              spacer,
              _selectedDate.formattedDate.text.make(),
              IconButton(
                  onPressed: _selectDate,
                  icon: const Icon(Icons.calendar_month))
            ],
          ),
          height20,
          Row(
            children: [
              Expanded(
                  child: TextField(
                focusNode: node,
                controller: textController,
              )),
              RoundButton(
                text: isEditMode?"완료":"추가",
                onTap: () {
                  widget.hide(
                      WriteTodoResult(_selectedDate, textController.text));
                },
              )
            ],
          ),
          height10,
        ],
      ),
    ));
  }
  bool get isEditMode => widget.todoForEdit!=null;

  void _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
    );
    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  //키보드 바로 보이게
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    AppKeyboardUtil.show(context, node);
  }
}