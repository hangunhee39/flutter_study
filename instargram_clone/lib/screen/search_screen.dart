import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SearchTextBar(),
            SearchGrid(),
          ],
        ),
      ),
    );
  }
}

class SearchTextBar extends StatelessWidget {
  const SearchTextBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(   //부모 widget에 영향을 받음 (높이)
          cursorColor: Colors.black, //커서 색
          decoration: InputDecoration(
            prefixIcon:  const Icon(Icons.search),
            hintText: '검색',
            //활성화 된 후
            border: OutlineInputBorder(
              borderRadius:  BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey.shade200, width: 1)
            ),
            //활성하 되기 전
            enabledBorder: OutlineInputBorder(
                borderRadius:  BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.grey.shade200, width: 1)
            ),
            contentPadding: const EdgeInsets.all(0),
            filled: true,
            fillColor: Colors.grey.shade200
          ),
        ),
      ),
    );
  }
}
//더미 데이터
final gridItem = List.generate(30, (index) => Colors.green.shade300);

class SearchGrid extends StatelessWidget {
  const SearchGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(  //gird 만들 때 builder or count
      padding: EdgeInsets.zero,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: gridItem.map((color) => Container(color: color,)).toList(),
    );
  }
}



