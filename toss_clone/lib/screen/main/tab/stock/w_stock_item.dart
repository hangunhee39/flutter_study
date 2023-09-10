import 'package:fast_app_base/common/common.dart';
import 'package:flutter/material.dart';

import 'vo/vo_stock.dart';

class StockItem extends StatelessWidget {
  final Stock stock;

  const StockItem({required this.stock, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Image.asset(
            stock.stockImagePath,
            width: 50,
          ),
          width20,
          (stock.stockName).text.size(18).bold.make(),
          const EmptyExpanded(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              stock.todayPerventageString.text.size(18).color(stock.priceColor(context)).make(),
              "${stock.currentPrice.toComma()}원".text.make(),
            ],
          )
        ],
      ),
    );
  }
}
