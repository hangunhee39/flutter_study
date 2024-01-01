import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../model/product.dart';

class SellerWidget extends StatefulWidget {
  const SellerWidget({super.key});

  @override
  State<SellerWidget> createState() => _SellerWidgetState();
}

//fireStore 등록 (add)
Future addCategories(String title) async {
  final db = FirebaseFirestore.instance;
  final ref = db.collection("category");
  await ref.add({"title": title});
}

//검색 기능
Stream<QuerySnapshot> streamProducts(String query) {
  final db = FirebaseFirestore.instance;
  if (query.isNotEmpty) {
    return db
        .collection("products")
        .orderBy("title")
        .startAt([query]).endAt(["$query\uf8ff"]).snapshots();
  }
  return db.collection("products").orderBy("timestamp").snapshots();
}

//전체 상품 불러오기
Future<List<Product>> fetchProducts() async {
  final db = FirebaseFirestore.instance;
  final resp = await db.collection("products").orderBy("timestamp").get();
  List<Product> items = [];
  for (var doc in resp.docs) {
    final item = Product.fromJson(doc.data());
    items.add(item);
  }

  return items;
}

class _SellerWidgetState extends State<SellerWidget> {
  TextEditingController searchTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchBar(
            controller: searchTEC,
            hintText: "상품명 입력",
            leading: const Icon(Icons.search),
            onTap: () {},
            onChanged: (s) {
              setState(() {});
            },
          ),
          const SizedBox(
            height: 16,
          ),
          ButtonBar(
            children: [
              ElevatedButton(
                onPressed: () {
                  TextEditingController tec = TextEditingController();
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            content: TextField(
                              controller: tec,
                            ),
                            actions: [
                              TextButton(
                                //
                                onPressed: () async {
                                  if (tec.text.isNotEmpty) {
                                    await addCategories(tec.text.trim());
                                    if (context.mounted) {
                                      Navigator.of(context).pop();
                                    }
                                  }
                                },
                                child: const Text("등록"),
                              )
                            ],
                          ));
                },
                child: const Text("카테고리 등록"),
              ),
              ElevatedButton(
                onPressed: () async {
                  List<String> categories = [
                    "정육",
                    "과일",
                    "과자",
                    "아이스크림",
                    "유제품",
                    "빵/쿠키",
                    "전자기기"
                  ];
                  final ref = FirebaseFirestore.instance.collection("category");
                  final tmp = await ref.get();

                  //중복 제거
                  for (var element in tmp.docs) {
                    await element.reference.delete(); //삭제
                  }

                  for (var element in categories) {
                    await ref.add({"title": element}); //일괄 등록
                  }
                },
                child: const Text("카테고리 일괄등록"),
              ),
            ],
          ),
          const Text(
            "싱픔목록",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Expanded(
            //StreamBuilder : 비동기 + stream(query) 사용 할때
            //FutureBuilder  : 비동기를 처리 할때 사용
            //snapshot : 비동기(Future)의 현재 상태를 받음
            //ㄴ>AsyncSnapshot : 비동기(Future)의 결과와 에러
            child: StreamBuilder(
              stream: streamProducts(searchTEC.text),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  //docId 값도 추가해서 받음
                  final items = snapshot.data?.docs
                      .map((e) =>
                          Product.fromJson(e.data() as Map<String, dynamic>)
                              .copyWith(docId: e.id))
                      .toList();
                  return ListView.builder(
                    itemCount: items?.length,
                    itemBuilder: (context, index) {
                      final item = items?[index];
                      return GestureDetector(
                        onTap: () {
                          print(item?.docId);
                        },
                        child: Container(
                          height: 120,
                          margin: const EdgeInsets.only(bottom: 16),
                          child: Row(
                            children: [
                              Container(
                                width: 120,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(8),
                                  //이미지 넣기
                                  image: DecorationImage(
                                      image: NetworkImage(item?.imgUrl ??
                                          "https://cdn.pixabay.com/photo/2023/11/22/20/31/snowman-8406382_1280.jpg"),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            item?.title ?? "제품 명 ??",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          PopupMenuButton(
                                            itemBuilder: (context) => [
                                              PopupMenuItem(
                                                  onTap: () {},
                                                  child: const Text("리뷰")),
                                              PopupMenuItem(
                                                child: const Text("삭제"),
                                                onTap: () async {
                                                  FirebaseFirestore.instance
                                                      .collection("products")
                                                      .doc(item?.docId)
                                                      .delete();
                                                },
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      Text("${item?.price} 원"),
                                      Text(switch (item?.isSale) {
                                        true => "할인 중",
                                        false => "할인 없음",
                                        _ => "??"
                                      }),
                                      Text("재고수량: ${item?.stock} 개")
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
