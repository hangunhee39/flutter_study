import 'package:fast_app_base/screen/notification/vo/vo_notification.dart';
import 'package:fast_app_base/screen/notification/w_notification_item.dart';
import 'package:flutter/material.dart';
import 'package:nav/dialog/dialog.dart';
import 'package:nav/enum/enum_nav_ani.dart';
import 'package:nav/nav.dart';

class NotificationDialog extends DialogWidget {
  final List<TossNotification> notification;

  //Dialog 애니메이션 주기
  //barrierDismissible : dialog 공간만 눌리게
  NotificationDialog(this.notification, {super.key, super.animation=NavAni.Bottom});

  @override
  State<NotificationDialog> createState() => _NotificationDialogState();
}

class _NotificationDialogState extends DialogState<NotificationDialog> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency, //dialog 배경 투명으로
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...widget.notification
              .map((e) => NotificationItemWidget(
                  onTap: () {
                    //dialog 닫기
                    widget.hide();
                  },
                  notification: e))
              .toList()
        ],
      ),
    );
  }
}
