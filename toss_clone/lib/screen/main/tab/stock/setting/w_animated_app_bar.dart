import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/widget/w_arrow.dart';
import 'package:flutter/material.dart';

class AnimatedAppBar extends StatefulWidget {
  final String title;
  final ScrollController controller;

  const AnimatedAppBar(this.title, {required this.controller, super.key});

  @override
  State<AnimatedAppBar> createState() => _AnimatedAppBarState();
}

class _AnimatedAppBarState extends State<AnimatedAppBar> with SingleTickerProviderStateMixin {
  final duration = 10.ms;
  late double scrollPosition = 0;

  //Explicit Animation
  late final controller = AnimationController(vsync: this);
  late Animation<double> animation = CurvedAnimation(parent: controller, curve: Curves.bounceInOut);

  @override
  void initState() {
    //animation start 느낌
    controller.forward();

    widget.controller.addListener(() {
      setState(() {
        scrollPosition = widget.controller.position.pixels;
      });
    });
    super.initState();
  }

  bool get isTriggered => scrollPosition > 80;

  double getValue(double initial, double target) {
    if (isTriggered) {
      return target;
    }
    double fraction = scrollPosition / 80;
    return initial + (target - initial) * fraction;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.black,
      child: SafeArea(
        child: Stack(
          children: [
            Tap(
                onTap: () {
                  Nav.pop(context);
                },
                child: const Arrow(
                  direction: AxisDirection.left,
                )).p20(),
            Positioned.fill(
                child: Align(
                    alignment: Alignment.topRight,
                    child: TweenAnimationBuilder<Color?>(
                      duration: 1000.ms,
                      tween: ColorTween(
                          begin: Colors.green,
                          end: isTriggered
                              ? Colors.orange
                              : Colors.green // 스크롤할때 바뀌게
                          ),
                      builder: (context, value, child) => ColorFiltered(
                          colorFilter: ColorFilter.mode(
                              value ?? Colors.green, BlendMode.modulate),
                          child: child),
                      child: Image.asset(
                        "$basePath/icon/map_point.png",
                        height: 60,
                        colorBlendMode: BlendMode.modulate,
                      ),
                    ))),
            AnimatedContainer(
              duration: duration,
              padding: EdgeInsets.only(
                left: getValue(20, 50),
                top: getValue(50, 15),
              ),
              child: AnimatedDefaultTextStyle(
                  duration: duration,
                  style: TextStyle(fontSize: getValue(30, 18)),
                  child: widget.title.text.make()),
            ),
          ],
        ),
      ),
    );
  }
}
