import 'dart:ffi';

import 'package:fast_app_base/common/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

class RiveLoginAnimationController {
  late void Function() runSuccessAnimation;
  late void Function() runFailAnimation;
}

class RiveLoginAnimation extends StatefulWidget {
  final bool check;
  final bool handsUp;
  final double lock;
  final RiveLoginAnimationController controller;

  const RiveLoginAnimation(
      {super.key,
      required this.check,
      required this.handsUp,
      required this.lock,
      required this.controller});

  @override
  State<RiveLoginAnimation> createState() => _RiveLoginAnimationState();
}

class _RiveLoginAnimationState extends State<RiveLoginAnimation> {
  late StateMachineController controller;
  late SMIBool smiCheck;

  late SMIBool smiHandsUp;

  late SMINumber smiLock;

  late SMITrigger smiSuccess;
  late SMITrigger smiFail;

  @override
  void initState() {
    widget.controller.runSuccessAnimation =(){
      smiSuccess.fire();
    };
    widget.controller.runFailAnimation = (){
      smiFail.fire();
    };
    super.initState();
  }

  //like가 바뀌어서 다시 생성될때
  @override
  void didUpdateWidget(covariant RiveLoginAnimation oldWidget) {
    if (oldWidget.check != widget.check) {
      smiCheck.value = widget.check;
    }
    if (oldWidget.handsUp != widget.handsUp) {
      smiHandsUp.value = widget.handsUp;
    }
    if (oldWidget.lock != widget.lock) {
      smiLock.value = widget.lock;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return RiveAnimation.asset(
      '$baseRivePath/login_animation.riv',
      stateMachines: const ['State Machine 1'],
      onInit: (Artboard art) {
        controller =
            StateMachineController.fromArtboard(art, 'State Machine 1')!;
        controller.isActive = true;
        art.addController(controller);
        smiCheck = controller.findInput<bool>('Check') as SMIBool;
        smiHandsUp = controller.findInput<bool>('hands_up') as SMIBool;
        smiLock = controller.findInput<double>('Look') as SMINumber;
        smiSuccess = controller.findInput<bool>('success') as SMITrigger;
        smiFail = controller.findInput<bool>('fail') as SMITrigger;
      },
    );
  }
}
