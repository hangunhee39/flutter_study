import 'package:fast_app_base/screen/main/tab/stock/vo/stock_perventage_data_provider.dart';
import 'package:fast_app_base/screen/main/tab/stock/vo/vo_popular_stock.dart';

class Stock extends PopularStock {
  final String stockImagePath;

  Stock({
    required this.stockImagePath,
    required super.yesterdayClosePrice,
    required super.currentPrice,
    required super.stockName,
  });
}
