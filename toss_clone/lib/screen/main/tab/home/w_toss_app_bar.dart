import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/dart/extension/context_extension.dart';
import 'package:flutter/material.dart';

class TossAppBar extends StatefulWidget {
  static const double appBarHeight = 60; //모든 곳에서 사용가능한 상수
  const TossAppBar({super.key});

  @override
  State<TossAppBar> createState() => _TossAppBarState();
}

class _TossAppBarState extends State<TossAppBar> {
  bool _showRedDot = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: TossAppBar.appBarHeight,
      color: context.appColors.appbarBackground,
      child: Row(
        children: [
          width10, //가로 여백 주기
          Image.asset(
            '$basePath/icon/toss.png',
            height: 30,
          ),
          Expanded(child: Container()),
          Image.asset(
            '$basePath/icon/map_point.png',
            height: 30,
          ),
          width10,
          Tap(
            onTap: () => setState(() => _showRedDot = !_showRedDot),
            child: Stack(children: [
              Image.asset(
                '$basePath/icon/notification.png',
                height: 30,
              ),
              if (_showRedDot)Positioned.fill(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.red),
                      ),
                    ))
            ]),
          ),
          width10
        ],
      ),
    );
  }
}
