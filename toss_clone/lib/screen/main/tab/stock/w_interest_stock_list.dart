import 'package:fast_app_base/screen/main/tab/stock/stocks_dummy.dart';
import 'package:flutter/material.dart';

import 'w_stock_item.dart';

class InterstStockList extends StatelessWidget {
  const InterstStockList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ...myInterestStocks.map((e) => StockItem(stock: e)).toList()
      ]
    );
  }
}
