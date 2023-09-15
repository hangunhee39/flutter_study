import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/dart/extension/datetime_extension.dart';
import 'package:fast_app_base/common/widget/w_big_button.dart';
import 'package:fast_app_base/screen/main/tab/stock/setting/d_number.dart';
import 'package:fast_app_base/screen/main/tab/stock/setting/w_animated_app_bar.dart';
import 'package:fast_app_base/screen/opensource/s_opensource.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../../common/data/preference/prefs.dart';
import 'w_swith_menu.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isPushOn = false;
  final scrollController =ScrollController();

  @override
  void initState() {
    isPushOn = Prefs.isPush.get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            SafeArea(
              child: ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: ListView(
                  controller: scrollController,
                //  padding: const EdgeInsets.only(top: 150) ,
                  children: [
                    //switch
                    SwitchMenu('푸시 설정', isPushOn, onTap: (isOn) {
                      Prefs.isPush.set(isOn);
                      setState(() {
                        isPushOn = isOn;
                      });
                    }),
                    Obx(
                          () =>
                          Slider(
                            value: Prefs.sliderPosition.get(),
                            onChanged: (value) {
                              Prefs.sliderPosition.set(value);
                            },
                          ),
                    ),
                    Obx(
                          () =>
                          BigButton(
                              '날짜 ${Prefs.birthDay.get() == null ? "" : Prefs.birthDay
                                  .get()
                                  ?.formattedDate}',
                              onTap: () async {
                                final data = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now().subtract(90.days),
                                    lastDate: DateTime.now().add(90.days));
                                if (data != null) {
                                  Prefs.birthDay.set(data);
                                }
                              }),
                    ),
                    Obx(
                          () =>
                          BigButton('지정된 숫자 ${Prefs.number.get()}', onTap: () async {
                            final number = await NumberDialog().show();
                            if (number != null) {
                              Prefs.number.set(number);
                            }
                          }),
                    ),
                    BigButton('오픈소스 화면', onTap: (){
                      Nav.push( OpensourceScreen());
                    }),
                    BigButton('오픈소스 화면', onTap: (){
                      Nav.push( OpensourceScreen());
                    }),
                    BigButton('오픈소스 화면', onTap: (){
                      Nav.push( OpensourceScreen());
                    }),
                    BigButton('오픈소스 화면', onTap: (){
                      Nav.push( OpensourceScreen());
                    }),
                    BigButton('오픈소스 화면', onTap: (){
                      Nav.push( OpensourceScreen());
                    }),
                    BigButton('오픈소스 화면', onTap: (){
                      Nav.push( OpensourceScreen());
                    }),
                    BigButton('오픈소스 화면', onTap: (){
                      Nav.push( OpensourceScreen());
                    }),
                    BigButton('오픈소스 화면', onTap: (){
                      Nav.push( OpensourceScreen());
                    }),
                    BigButton('오픈소스 화면', onTap: (){
                      Nav.push( OpensourceScreen());
                    }),BigButton('오픈소스 화면', onTap: (){
                      Nav.push( OpensourceScreen());
                    }),
                    BigButton('오픈소스 화면', onTap: (){
                      Nav.push( OpensourceScreen());
                    }),

                    //slider
                    //date time
                    //numberDiaglog
                  ],
                ).pOnly(top: 20),
              ),
            ),
            AnimatedAppBar("설정", controller: scrollController).p(1)
          ],
        ));
  }
}
