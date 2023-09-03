import 'package:flutter/material.dart';

import '../enum.dart';

class GameResult extends StatelessWidget {
  final bool isDone;    //사용자 입력 전/후
  final Result? result; //결과값 받아옴
  final VoidCallback callback; //다시하기 눌렀을 때 callBack

  const GameResult({required this.callback, required this.isDone, this.result, super.key});

  @override
  Widget build(BuildContext context) {
    if (isDone){
      //사용자 입력 후 화면
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(result!.displayString
          ,style: const TextStyle(fontSize: 32),),
          const SizedBox(height: 8,),
          TextButton(onPressed: ()=> callback.call(), child: const Text("다시 하기", style: TextStyle(fontSize: 24),))
        ],
      );
    }
    //사용자 입력 전 화면
    return const Center(
      child: Text("가위, 바위, 보 중 하나를 선탤 해 주세요.",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
    );
  }
}
