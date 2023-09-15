import 'package:animations/animations.dart';
import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/dart/extension/datetime_extension.dart';
import 'package:fast_app_base/screen/main/tab/stock/search/popular_stock_dummy.dart';
import 'package:fast_app_base/screen/main/tab/stock/search/s_stock_detail.dart';
import 'package:flutter/material.dart';

import 'w_popular_stock_item.dart';

class PopularSearchStockList extends StatelessWidget {
  const PopularSearchStockList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            '인기 검색'.text.bold.make(),
            EmptyExpanded(),
            '오늘 ${DateTime.now().formattedTime} 기준'
                .text
                .size(12)
                .color(Colors.grey)
                .make(),
          ],
        ).pSymmetric(h: 20),
        height20,
        ...popularStockList.mapIndexed(
          (e, index) => OpenContainer<bool>(  //animations 넣기 screen 열릴때 자연스럽게
            closedColor: Colors.black,
            openColor: Colors.black,
            openBuilder: (BuildContext context, VoidCallback _) {
              return StockDetailScreen(e.stockName);
            },
            closedBuilder: (BuildContext context, VoidCallback _) {
              return PopularStockItem(stock: e, number: index + 1);
            },
          ),
        )
        //PopularStockItem(stock: e, number: index + 1).toList()
      ],
    ).pSymmetric(h: 20);
  }
}
