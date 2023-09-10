import 'package:fast_app_base/common/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract mixin class StockPercentageDateProvider{

  //abstact 에서 get : 있다고 가정함
  int get currentPrice;
  int get yesterdayClosePrice;


  double get todayPercentage =>
      ((currentPrice - yesterdayClosePrice) / yesterdayClosePrice * 100)
          .toPrecision(2);

  String get todayPerventageString => "$symbol$todayPercentage%";

  bool get isPlus => currentPrice > yesterdayClosePrice;

  bool get isSame => currentPrice == yesterdayClosePrice;

  bool get isMinus => currentPrice < yesterdayClosePrice;

  String get symbol => isSame ? "" : isPlus ? "+": "";

  Color priceColor(BuildContext context) => isSame ? context.appColors.lessImportColor: isPlus ? context.appColors.plus : context.appColors.minus;

}