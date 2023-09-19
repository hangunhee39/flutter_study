import 'dart:math';

import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/widget/w_round_button.dart';
import 'package:fast_app_base/common/widget/w_rounded_container.dart';
import 'package:fast_app_base/screen/main/tab/stock/setting/w_rive_login_animation.dart';
import 'package:flutter/material.dart';
import 'package:nav/dialog/dialog.dart';
import 'package:nav/enum/enum_nav_ani.dart';

class NumberDialog extends DialogWidget<int> {
  NumberDialog({super.key, super.animation = NavAni
      .Fade, super.barrierDismissible = false});

  @override
  DialogState<NumberDialog> createState() => _NotificationDialogState();
}

class _NotificationDialogState extends DialogState<NumberDialog> {
  //눌렀을 때  컨트롤러
  final controller = TextEditingController();
  final passController = TextEditingController();

  //눌렀을 때 이벤트 변경
  final numberFocus = FocusNode();
  final passFocus = FocusNode();

  final loginController = RiveLoginAnimationController();

  bool check = false;
  bool hansUp = false;
  double lock = 0.0;

  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        lock = controller.text.length.toDouble() * 1.5;
      });
    });

    numberFocus.addListener(() {
      setState(() {
        check = numberFocus.hasFocus;
      });
    });

    passFocus.addListener(() {
      hansUp = passFocus.hasFocus;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      //type: MaterialType.transparency,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundedContainer(
              child: Column(
                children: [
                  '숫자를 입력해주세요'.text.make(),
                  SizedBox(
                    width: 250,
                    height: 250,
                    child: RiveLoginAnimation(
                      controller: loginController,
                      check: check, handsUp: hansUp, lock: lock,),
                  ),
                  TextField(
                    focusNode: numberFocus,
                    controller: controller,
                    keyboardType: TextInputType.number,),
                  TextField(
                    focusNode: passFocus,
                    obscureText: true,
                    controller: passController,
                    keyboardType: TextInputType.number,),
                  RoundButton(text: '완료', onTap: () async {
                    final text = controller.text;
                    try{
                      int number = int.parse(text);
                      loginController.runSuccessAnimation();
                      await sleepAsync(1000.ms);
                      widget.hide(number);
                    }catch(e){
                      loginController.runFailAnimation();
                    }
                  })
                ],
              ))
        ],
      ),
    );
  }
}