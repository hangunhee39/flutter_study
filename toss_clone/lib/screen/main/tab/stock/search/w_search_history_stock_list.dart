import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/data/preference/app_preferences.dart';
import 'package:fast_app_base/screen/main/tab/stock/search/s_stock_detail.dart';
import 'package:flutter/material.dart';

import 'search_stock_data.dart';

class SearchHistoryStockList extends StatefulWidget {
  const SearchHistoryStockList({super.key});

  @override
  State<SearchHistoryStockList> createState() => _SearchHistoryStockListState();
}

class _SearchHistoryStockListState extends State<SearchHistoryStockList>
    with SearchStockDataProvider {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 65,
      child: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.only(top: 5),
          scrollDirection: Axis.horizontal,
          itemCount: searchData.searchHistoryList.length,
          itemBuilder: (context, index) => Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 8),
                child: Row(
                  children: [
                    Tap(
                      onTap: () {
                        Nav.push(StockDetailScreen(
                            searchData.searchHistoryList[index]));
                      },
                      child: searchData.searchHistoryList[index].text.make(),
                    ),
                    Tap(
                        onTap: () {
                          searchData.removeHistory(
                              searchData.searchHistoryList[index]);
                        },
                        child:
                        const Icon(Icons.close, size: 16,))
                  ],
                )
                    .box
                    .withRounded(value: 6)
                    .color(context.appColors.roundedLayoutBackground)
                    .p8
                    .make(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
