
import 'package:shared_preferences/shared_preferences.dart';

//SingleTaskToon
class AppSharedPreference {
  late SharedPreferences _preferences;

  //프라이빗 생성자 (생성을 내부에 할때)
  AppSharedPreference._();

  //내부 인스턴스
  static AppSharedPreference instance =AppSharedPreference._();

  static init() async {
    instance._preferences = await SharedPreferences.getInstance();
  }

  static const keyCount = "keyCount";
  //---------init ---------

  static void setCount(int count){
    instance._preferences.setInt(keyCount, count);
  }

  ///null일때 0 디폴트 값
  static int getCount(){
    return instance._preferences.getInt(keyCount) ??0;
  }
}