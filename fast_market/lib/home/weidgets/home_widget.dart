import 'package:dots_indicator/dots_indicator.dart';
import 'package:fast_market/home/product_detail_screen.dart';
import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  PageController pageController = PageController();
  int bannerIndex = 0;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 140,
            color: Colors.indigo,
            margin: EdgeInsets.only(bottom: 8),
            child: PageView(
              controller: pageController,
              children: [
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(8),
                  child: Image.asset("assets/fastcampus_logo.png"),
                ),
                Container(
                  color: Colors.blue,
                  padding: EdgeInsets.all(8),
                  child: Image.asset("assets/fastcampus_logo.png"),
                ),
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.all(8),
                  child: Image.asset("assets/fastcampus_logo.png"),
                ),
              ],
              onPageChanged: (idx) {
                setState(() {
                  bannerIndex = idx;
                });
              },
            ),
          ),
          DotsIndicator(
            dotsCount: 3,
            position: bannerIndex,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16),
            margin: EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "카테고리",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    TextButton(onPressed: () {}, child: Text("더보기")),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                //todo : 카테고리 목록 받아로는 위젯
                Container(
                  height: 240,
                  color: Colors.red,
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 24),
            padding: EdgeInsets.only(left: 16, top: 8, bottom: 16),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "오늘의 특가",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    TextButton(onPressed: () {}, child: const Text("더보기"))
                  ],
                ),
                Container(
                  height: 240,
                  color: Colors.orange,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context)=> ProductDetailScreen())
                            );
                          },
                          child: Container(
                            width:160,
                            margin: const EdgeInsets.only(right: 16),
                            decoration: const BoxDecoration(
                              color: Colors.grey
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
