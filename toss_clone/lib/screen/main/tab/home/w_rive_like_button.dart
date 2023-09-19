import 'dart:ffi';

import 'package:fast_app_base/common/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

class RiveLikeButton extends StatefulWidget {
  final bool isLike;
  final void Function(bool isLike) onTapLike;

  const RiveLikeButton(this.isLike, {required this.onTapLike, super.key});

  @override
  State<RiveLikeButton> createState() => _RiveLikeButtonState();
}

class _RiveLikeButtonState extends State<RiveLikeButton> {
  late StateMachineController controller;
  late SMIBool smiPressed ;
  late SMIBool smiHover  ;

  //like가 바뀌어서 다시 생성될때
  @override
  void didUpdateWidget(covariant RiveLikeButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isLike != widget.isLike) {
      smiPressed.value = widget.isLike;
      smiHover.value = widget.isLike;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Tap(
      onTap: (){
        widget.onTapLike(!widget.isLike);
      },
      child: RiveAnimation.asset(
        '$baseRivePath/light_like.riv',
        stateMachines: const ['State Machine 1'],
        onInit: (Artboard art){
          controller = StateMachineController.fromArtboard(art, 'State Machine 1')!;
          controller.isActive = true;
          art.addController(controller);
          smiPressed = controller.findInput<bool>('Pressed') as SMIBool;
          smiHover = controller.findInput<bool>('Hover') as SMIBool;
        },
      ),
    );
  }
}
