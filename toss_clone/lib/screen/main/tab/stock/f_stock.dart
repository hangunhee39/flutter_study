import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/widget/w_image_button.dart';
import 'package:flutter/material.dart';

import 'f_my_stock.dart';
import 'f_todays_discovery.dart';

class StockFragment extends StatefulWidget {
  const StockFragment({super.key});

  @override
  State<StockFragment> createState() => _StockFragmentState();
}

class _StockFragmentState extends State<StockFragment>
    with SingleTickerProviderStateMixin {
  late final TabController tabController =
      TabController(length: 2, vsync: this);
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: context.appColors.roundedLayoutBackground,
          pinned: true, //앱바 고정
          actions: [
            ImageButton(
              onTap: () {
                context.showSnackbar("calendar");
              },
              imagePath: '$basePath/icon/stock_calendar.png',
              height: 26,
              width: 26,
            ),
            ImageButton(
              onTap: () {
                context.showSnackbar("search");
              },
              imagePath: '$basePath/icon/stock_search.png',
              height: 26,
              width: 26,
            ),
            ImageButton(
              onTap: () {
                context.showSnackbar("setting");
              },
              imagePath: '$basePath/icon/stock_settings.png',
              height: 26,
              width: 26,
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              title,
              tabBar,
              if (currentIndex==0)
                const MyStockFragment()
              else
                const TodaysDiscoveryFragment()
            ],
          ),
        )
      ],
    );
  }

  Widget get title => Container(
    color: context.appColors.roundedLayoutBackground,
    child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            '토스증권'.text.size(24).bold.make(),
            width20,
            'S&P 500'
                .text
                .size(13)
                .bold
                .color(context.appColors.lessImportColor)
                .make(),
            width10,
            3919.29
                .toComma()
                .toString()
                .text
                .size(13)
                .bold
                .color(context.appColors.plus)
                .make(),
          ],
        ).pOnly(left: 20),
  );

  Widget get tabBar => Container(
    color: context.appColors.roundedLayoutBackground,
    child: Column(
          children: [
            TabBar(
                onTap: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                labelColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.tab,
                //indicator tab 사이즈로 맞추기
                indicatorPadding: const EdgeInsets.symmetric(horizontal: 20),
                labelPadding: const EdgeInsets.symmetric(vertical: 20),
                labelStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                indicatorColor: Colors.white,
                controller: tabController,
                tabs: ['내 주식'.text.make(), '오늘의 발견'.text.make()]),
            const Line(),
          ],
        ),
  );
}
