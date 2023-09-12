import 'package:fast_app_base/screen/main/tab/stock/search/search_stock_data.dart';
import 'package:fast_app_base/screen/main/tab/stock/search/w_popular_search_stock_list.dart';
import 'package:fast_app_base/screen/main/tab/stock/search/w_search_auto_complete_list.dart';
import 'package:fast_app_base/screen/main/tab/stock/search/w_search_history_stock_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'w_stock_search_app_bar.dart';

class SearchStockScreen extends StatefulWidget {
  const SearchStockScreen({super.key});

  @override
  State<SearchStockScreen> createState() => _SearchStockScreenState();
}

class _SearchStockScreenState extends State<SearchStockScreen> {
  final controller = TextEditingController();
  late final searchData = Get.find<SearchStockData>();

  @override
  void initState() {
    Get.put(SearchStockData());
    controller.addListener(() {
      searchData.search(controller.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<SearchStockData>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: StockSearchAppBar(textEditingController: controller),
        //Rx 객체를 관찰해서 변화가 있을때 마다 갱신 setState 안써도 됨!
        body: Obx(
          () => searchData.autoCompleteList.isEmpty
              ? ListView(
                  children: const [
                    SearchHistoryStockList(),
                    PopularSearchStockList(),
                  ],
                )
              : SearchAutoCompleteList(controller),
        ));
  }
}
