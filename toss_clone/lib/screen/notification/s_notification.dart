import 'package:fast_app_base/screen/notification/d_notification.dart';
import 'package:fast_app_base/screen/notification/notification_dummy.dart';
import 'package:fast_app_base/screen/notification/w_notification_item.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        //CustomScrollView 사용이유 : 여러 스크롤뷰를 통합
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text("알림"),
              centerTitle: false,
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    childCount: notificationDunnies.length,
                    (context, index) => NotificationItemWidget(
                        onTap: () {
                          NotificationDialog([notificationDunnies[index]]).show();
                        },
                        notification: notificationDunnies[index])))
          ],
        ),
      ),
    );
  }
}
