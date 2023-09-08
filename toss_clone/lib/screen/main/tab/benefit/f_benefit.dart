import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/widget/w_height_and_width.dart';
import 'package:fast_app_base/screen/main/s_main.dart';
import 'package:fast_app_base/screen/main/tab/benefit/benefit_dummy.dart';
import 'package:fast_app_base/screen/main/tab/benefit/w_benefit_item.dart';
import 'package:fast_app_base/screen/main/tab/benefit/w_point_button.dart';
import 'package:flutter/material.dart';

class BenefitFragment extends StatefulWidget {
  const BenefitFragment({super.key});

  @override
  State<BenefitFragment> createState() => _BenefitFragmentState();
}

class _BenefitFragmentState extends State<BenefitFragment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.appColors.roundedLayoutBackground,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: MainScreenState.bottomNavHeight),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            height30,
            "혜택".text.white.bold.size(24).make(),
            height30,
            const PointButton(point: 500),
            height20,
            "혜택 더 받기".text.white.bold.size(20).make(),

            ...benefitList.map((e) => BenefitItem(benefit: e,)).toList(),
          ],
        ).pSymmetric(h: 20),
      ),
    );
  }
}
