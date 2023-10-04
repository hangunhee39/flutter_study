import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';

@freezed
class Bank{
  final String name;
  final String logoImagePath;

  Bank(this.name, this.logoImagePath);

  //bank들끼리 비교
  @override
  bool operator ==(Object other) {
    if(identical(this, other)){
      return true;
    }
    if(other.runtimeType != runtimeType){
      return false;
    }

    return other is Bank && other.name ==name;
  }
}