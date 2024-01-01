import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_market/home/camera_example_page.dart';
import 'package:fast_market/model/category.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductAddScreen extends StatefulWidget {
  const ProductAddScreen({super.key});

  @override
  State<ProductAddScreen> createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isSale = false;

  final db = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

  //image picker 사용
  Uint8List? imageData; //image 8비트 저장
  XFile? image; //image 저장

  Category? selectedCategory;

  TextEditingController titleTEC = TextEditingController();
  TextEditingController descriptionTEC = TextEditingController();
  TextEditingController priceTEC = TextEditingController();
  TextEditingController stockTEC = TextEditingController();
  TextEditingController salePercentTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("상품 추가"),
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return CameraExamplePage();
            }));
          }, icon: const Icon(Icons.camera)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.batch_prediction)),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(

                //imagePicker 사용
                onTap: () async {
                  final ImagePicker picker = ImagePicker();
                  image = await picker.pickImage(source: ImageSource.gallery);
                  imageData = await image?.readAsBytes();

                  setState(() {

                  });
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 240,
                    width: 240,
                    decoration: BoxDecoration(
                      color: Colors.grey[200]!,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: imageData == null ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add),
                        Text("체품(상품) 이미지 추가"),
                      ],
                    ) : Image.memory(
                      imageData!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  "기본정보",
                  style: Theme
                      .of(context)
                      .textTheme
                      .headlineSmall,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: titleTEC,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "상풍명",
                        hintText: "제품명을 입력하세요.",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "필수 입력 항목입니다.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: descriptionTEC,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "상품 설명",
                      ),
                      maxLength: 256,
                      maxLines: null,
                      //input 칸 늘어남
                      keyboardType: TextInputType.multiline,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "필수 입력 항목입니다.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: priceTEC,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "가격(단가)",
                        hintText: "1개 가격 입력",
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "필수 입력 항목입니다.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: stockTEC,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "수량",
                        hintText: "입고 및 재고 수량",
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "필수 입력 항목입니다.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SwitchListTile.adaptive(
                      value: isSale,
                      onChanged: (v) {
                        setState(() {
                          isSale = v;
                        });
                      },
                      title: const Text("할인여부"),
                    ),
                    if (isSale)
                      TextFormField(
                        controller: salePercentTEC,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "할인율",
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          return null;
                        },
                      ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "카테고리 선택",
                        style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    DropdownButton(
                        isExpanded: true, items: const [], onChanged: (s) {}),
                    const SizedBox(
                      height: 16,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
