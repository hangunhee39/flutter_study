import 'package:flutter/material.dart';
import 'package:rock_paper_scissors/game/enum.dart';

import 'input_card.dart';

class UserInput extends StatelessWidget {
  final bool isDone;  //사용자 입력 전/후
  final InputType? userInput; //사용자 입력 값 받아옴
  final Function(InputType) callBack; //사용자 입력 callBack 함수

  const UserInput({required this.isDone, this.userInput, required this.callBack, super.key});

  @override
  Widget build(BuildContext context) {
    if (isDone) {
      //입력 후 보여주는 화면
      return Row(
        children: [
          const Expanded(child: SizedBox.shrink()),
          Expanded(child: InputCard(child: Image.asset(userInput!.path))),
          const Expanded(child: SizedBox.shrink()),
        ],
      );
    }

    //입력전 보여주는 화면
    return Row(
      children: _getInputs(callBack),
    );
  }

  //사용자 입력 함수
  List<Widget> _getInputs(Function(InputType) callback) {
    return InputType.values
        .map((type) => Expanded(
          child: InkWell(
            onTap: () => callback.call(type), //사용자 입력 값을 callBack
            child: InputCard(
                  child: Image.asset(type.path),
                ),
          ),
        ))
        .toList();
  }
}
