import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("패스트 제품 상제"),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 320,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(color: Colors.orange),
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 24),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                            ),
                            child: Text(
                              "할인중",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "패캠 플러터",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                            PopupMenuButton(itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  child: const Text("리뷰 등록"),
                                  onTap: () {

                                    int reviewScore = 0;

                                    //매우 중요 : PopupMenu 안에 Dialog 실행 https://stackoverflow.com/questions/69939559/showdialog-bug-dialog-isnt-triggered-from-popupmenubutton-in-flutter
                                    Future.delayed(
                                        const Duration(seconds: 0),
                                        () => showDialog(
                                              context: context,
                                              builder: (context) {
                                                TextEditingController reviewTEC=TextEditingController();

                                                //매우 중요 : 위젯(dialog) 내부에서 값 갱신
                                                return StatefulBuilder(
                                                  builder: (context, setState) {
                                                    return AlertDialog(
                                                      title: const Text("리뷰 등록"),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(),
                                                          child: const Text("취소"),
                                                        ),
                                                        TextButton(
                                                            onPressed: () {},
                                                            child:
                                                                const Text("등록"))
                                                      ],
                                                      content: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          TextFormField(
                                                            controller: reviewTEC,
                                                          ),
                                                          Row(
                                                            children:
                                                                List.generate(
                                                              5,
                                                              (index) => IconButton(
                                                                onPressed: (){
                                                                  setState(
                                                                      ()=> reviewScore =index
                                                                  );
                                                                },
                                                                icon: Icon(Icons.star,
                                                                color: //:삼항연산자로 구현
                                                                    index <= reviewScore ? Colors.orange : Colors.grey),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }
                                                );
                                              },
                                            ));
                                  },
                                ),
                              ];
                            }),
                          ],
                        ),
                        Text("제품 상세 정보"),
                        Text("상세상제"),
                        Row(
                          children: [
                            Text(
                              "1000원",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                            Spacer(),
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                            ),
                            Text("4.5")
                          ],
                        )
                      ],
                    ),
                  ),
                  //mixin 안하고 Tab 쓰는 법 : DefaultTabController
                  DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        TabBar(tabs: [
                          Tab(
                            text: "제품 상세",
                          ),
                          Tab(
                            text: "리뷰",
                          )
                        ]),
                        Container(
                          height: 500,
                          child: TabBarView(
                            children: [
                              Container(
                                child: Text("상세"),
                              ),
                              Container(
                                child: Text("리뷰"),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            // onTap: () {
            //   showDialog(
            //     context: context,
            //     builder: (context) {
            //       return AlertDialog(
            //         title: Text("리뷰 등록"),
            //         actions: [
            //           TextButton(
            //             onPressed: () => Navigator.of(context).pop(),
            //             child: Text("취소"),
            //           ),
            //           TextButton(onPressed: () {}, child: Text("등록"))
            //         ],
            //         content: Column(
            //           mainAxisSize: MainAxisSize.max,
            //           children: [
            //             TextFormField(),
            //             Row(
            //               children: List.generate(
            //                 5,
            //                 (index) => const Icon(
            //                   Icons.star,
            //                   color: Colors.orange,
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       );
            //     },
            //   );
            // },
            child: Container(
              height: 72,
              decoration: BoxDecoration(
                color: Colors.red[100],
              ),
              child: Center(
                child: Text(
                  "장바구니",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
