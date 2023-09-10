import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/widget/w_arrow.dart';
import 'package:fast_app_base/common/widget/w_rounded_container.dart';
import 'package:fast_app_base/screen/main/tab/stock/w_interest_stock_list.dart';
import 'package:flutter/material.dart';

import '../../../../common/widget/w_long_button.dart';

class MyStockFragment extends StatelessWidget {
  const MyStockFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [myAccount(context), height20, myStocks(context)],
    );
  }

  //getter는 context를 바로 못씀 -> 함수로 변경
  Widget myAccount(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: context.appColors.roundedLayoutBackground,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            height20,
            '계좌'.text.size(18).make(),
            Row(
              children: [
                '5002원'.text.size(24).bold.make(),
                const Arrow(),
                EmptyExpanded(),
                RoundedContainer(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  radius: 8,
                  backgroundColor: context.appColors.buttonBackground,
                  child: '채우기'.text.size(12).make(),
                ),
              ],
            ),
            height20,
            Line(
              color: context.appColors.divider,
            ),
            height20,
            const LongButton(title: '주문내역'),
            height20,
            Line(
              color: context.appColors.divider,
            ),
            height20,
            const LongButton(title: '판매수익'),
            height20,
          ],
        ),
      );

  Widget myStocks(BuildContext context) => Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: context.appColors.roundedLayoutBackground,
            child: Column(
              children: [
                height30,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    '관심주식'.text.size(20).bold.make(),
                    '편집하기'.text.color(context.appColors.lessImportColor).make()
                  ],
                ),
                Tap(
                  onTap: () {
                    context.showSnackbar('기본');
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        '기본'.text.size(16).make(),
                        const Arrow(
                          direction: AxisDirection.up,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          InterstStockList().pSymmetric(h:15)
        ],
      );
}
