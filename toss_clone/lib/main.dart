import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'app.dart';
import 'common/data/preference/app_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

void main() async {
  //Flutter NativeSplash 화면 유지 (로그인 등 사용)
  final bindings = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: bindings);

  await EasyLocalization.ensureInitialized();
  await AppPreferences.init();
  //타임 스템프
  timeago.setLocaleMessages('ko', timeago.KoMessages());

  runApp(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ko')],
      fallbackLocale: const Locale('en'),
      path: 'assets/translations',
      useOnlyLangCode: true,
      child: const App()));
}
