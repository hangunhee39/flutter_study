import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/screen/notification/vo/vo_notification.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationItemWidget extends StatefulWidget {
  final TossNotification notification;
  final VoidCallback onTap;

  const NotificationItemWidget({required this.onTap, required this.notification, super.key});

  @override
  State<NotificationItemWidget> createState() => _NotificationItemWidgetState();
}

class _NotificationItemWidgetState extends State<NotificationItemWidget> {
  static const  leftPadding = 10.0;
  static const iconWidth = 25.0;

  @override
  Widget build(BuildContext context) {
    return Tap(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: leftPadding),
        color: widget.notification.isRead? context.backgroundColor: context.appColors.unreadColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                width10,
                Image.asset(widget.notification.type.iconPath,width: iconWidth,),
                widget.notification.type.name.text.size(12).color(context.appColors.lessImportColor).make(),
                EmptyExpanded(),
                timeago.format(widget.notification.time , locale: context.locale.languageCode)
                    .text.size(13).color(context.appColors.lessImportColor).make(),
                width10,
              ],
            ),
            widget.notification.description.text.size(16).make().pOnly(left: leftPadding + iconWidth)
          ],
        ),
      ),
    );
  }
}
