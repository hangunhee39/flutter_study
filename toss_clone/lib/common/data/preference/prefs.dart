import 'package:fast_app_base/common/data/preference/item/nullable_preference_item.dart';
import 'package:fast_app_base/common/data/preference/item/rx_preference_item.dart';
import 'package:fast_app_base/common/theme/custom_theme.dart';

import 'item/preference_item.dart';
import 'item/rxn_preference_item.dart';

class Prefs {
  static final appTheme = NullablePreferenceItem<CustomTheme>('appTheme');
  static final isPush = PreferenceItem<bool>('appTem',false);
  //전역적이게 생성
  static final sliderPosition = RxPreferenceItem<double, RxDouble>('sliderPosition',0.0);
  //객체를 null 한 rx
  static final birthDay = RxnPreferenceItem<DateTime, Rxn<DateTime>>('birthday');
  static final number = RxPreferenceItem<int, RxInt>('number',0);
}
