import 'package:fast_market/home/cart_screen.dart';
import 'package:fast_market/home/product_add_screen.dart';
import 'package:fast_market/home/weidgets/home_widget.dart';
import 'package:fast_market/home/weidgets/seller_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _menuIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("패스트 마켓"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.logout)),
          //홈 화면에서만 검색 아이콘 보이게
          if (_menuIndex == 0)
            IconButton(
                onPressed: () {}, icon: const Icon(CupertinoIcons.search)),
        ],
      ),
      body: IndexedStack(
        index: _menuIndex,
        children: [
          HomeWidget(),
          SellerWidget(),
        ],
      ),
      //floatingButton 분개처리
      floatingActionButton: switch (_menuIndex) {
        0 => FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CartScreen(),
                ),
              );
            },
            child: const Icon(Icons.shopping_cart_outlined),
          ),
        1 => FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductAddScreen(),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        _ => Container()
      },
      bottomNavigationBar: NavigationBar(
        //이후 상태 관리 작업
        selectedIndex: _menuIndex,
        onDestinationSelected: (inx) {
          setState(() {
            _menuIndex = inx;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.store_outlined), label: "홈"),
          NavigationDestination(
              icon: Icon(Icons.storefront), label: "사장님(판매자)"),
        ],
      ),
    );
  }
}
