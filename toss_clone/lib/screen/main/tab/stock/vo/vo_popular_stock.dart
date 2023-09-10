import 'package:fast_app_base/screen/main/tab/stock/vo/stock_perventage_data_provider.dart';
import 'package:fast_app_base/screen/main/tab/stock/vo/vo_simple_stock.dart';

class PopularStock extends SimpleStock with StockPercentageDateProvider{
  @override
  final int yesterdayClosePrice;
  @override
  final int currentPrice;

  //부모 까지 한번에 생성함
  // {} <- named paremetar
  PopularStock(
      {required this.yesterdayClosePrice,
      required this.currentPrice,
      required String stockName})
      : super(stockName);
}
