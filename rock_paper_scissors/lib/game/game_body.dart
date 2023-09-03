import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rock_paper_scissors/game/enum.dart';
import 'package:rock_paper_scissors/game/widget/user_input.dart';

import 'widget/cpu_input.dart';
import 'widget/game_result.dart';

class GameBody extends StatefulWidget {
  const GameBody({super.key});

  @override
  State<GameBody> createState() => _GameBodyState();
}

class _GameBodyState extends State<GameBody> {
  late bool isDone;   //사용자 입력 전/후
  InputType? _userInput; //null 일때는 late 붙이면 안됨(stless 에서) /사용자 입력값
  late InputType _cpuInput; //cpu 입력값

  @override
  void initState() {
    super.initState();
    isDone = false;
    setCpuInput();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: CpuInput(isDone: isDone, cpuInput: _cpuInput)),
        Expanded(child: GameResult(isDone: isDone, result: getResult(), callback: reset)),
        Expanded(
            child: UserInput(
                isDone: isDone, userInput: _userInput, callBack: setUserInput)),
      ],
    );
  }

  //사용자 입력 가져오기
  void setUserInput(InputType userInput) {
    setState(() {
      isDone = true;
      _userInput = userInput;
    });
  }

  //cpu 입력 가져오기
  void setCpuInput() {
    final random = Random();
    _cpuInput = InputType.values[random.nextInt(3)];
  }

  //다시하기 버튼 눌렀을때 callBack 함수
  void reset() {
    setState(() {
      isDone = false;
      setCpuInput();
    });
  }

  //결과 가져우는 함수
  Result? getResult() {
    if (_userInput == null) return null;

    switch (_userInput!) {
      case InputType.rock:
        switch (_cpuInput) {
          case InputType.rock:
            return Result.draw;
          case InputType.scissors:
            return Result.playerWin;
          case InputType.paper:
            return Result.cpuWin;
        }
      case InputType.scissors:
        switch (_cpuInput) {
          case InputType.rock:
            return Result.cpuWin;
          case InputType.scissors:
            return Result.draw;
          case InputType.paper:
            return Result.playerWin;
        }
      case InputType.paper:
        switch (_cpuInput) {
          case InputType.rock:
            return Result.playerWin;
          case InputType.scissors:
            return Result.cpuWin;
          case InputType.paper:
            return Result.draw;
        }
    }
  }
}
