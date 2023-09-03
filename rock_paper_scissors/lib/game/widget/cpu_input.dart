import 'package:flutter/material.dart';
import 'package:rock_paper_scissors/game/enum.dart';
import 'package:rock_paper_scissors/game/widget/input_card.dart';

class CpuInput extends StatelessWidget {
  final bool isDone;  //사용자 입력 전/후
  final InputType cpuInput; //cpu 입력 값

  const CpuInput({required this.isDone, required this.cpuInput, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Expanded(child: SizedBox.shrink()), //빈 박스
      Expanded(
        child: InputCard(
          child: getCpuInput(),
        ),
      ),
      const Expanded(child: SizedBox.shrink()), //빈박스
    ]);
  }

  //사용자 입력에 따라 다른 화면 보이게
  Widget getCpuInput() {
    if (isDone) {
      return Image.asset(cpuInput.path);
    }
    return const SizedBox(
        height: 67,
        child: Center(
            child: Text(
          "?",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        )));
  }
}
