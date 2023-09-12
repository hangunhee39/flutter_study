import 'package:fast_app_base/common/util/local_json.dart';
import 'package:fast_app_base/screen/main/tab/stock/vo/vo_simple_stock.dart';
import 'package:get/get.dart';

abstract mixin class SearchStockDataProvider {
  late final searchData = Get.find<SearchStockData>();
}

//데이터 동적 관리!!
class SearchStockData extends GetxController {
  List<SimpleStock> stocks = [];
  RxList<String> searchHistoryList = <String>[].obs;
  RxList<SimpleStock> autoCompleteList = <SimpleStock>[].obs;

  @override
  void onInit() {
    searchHistoryList.addAll(['삼성전자', 'LG전자', '현대차', '넷플릭스']);
    loadLocalStockJson();

    super.onInit();
  }

  //json -> list 변환
  Future<void> loadLocalStockJson() async {
    final jsonList =
        await LocalJson.getObjectList<SimpleStock>("json/stock_list.json");
    stocks.addAll(jsonList);
  }

  //검색
  void search(String keyword) {
    //키워드가 비어 있을 때
    if (keyword.isEmpty){
      autoCompleteList.clear();
      return;
    }
    autoCompleteList.value =
        stocks.where((element) => element.stockName.contains(keyword)).toList();
  }

  //검색기록 저장
  void addHistory(SimpleStock stock){
    if (searchHistoryList.contains(stock.stockName)){
      searchHistoryList.remove(stock.stockName);
    }
    searchHistoryList.add(stock.stockName);
  }

  void removeHistory(String stock) {
    searchHistoryList.remove(stock);
  }
}
