import 'package:fhcs_mobile_application/controller/notification/notificationController.dart';
import 'package:fhcs_mobile_application/screens/notification/notification_history_action/components/notification_history_action_body.dart';
import 'package:fhcs_mobile_application/widgets/ScreenShared/screen_without_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationHistoryAction extends StatefulWidget {
  const NotificationHistoryAction({Key key}) : super(key: key);

  @override
  _NotificationHistoryActionState createState() =>
      _NotificationHistoryActionState();
}

class _NotificationHistoryActionState extends State<NotificationHistoryAction> {
  final NotificationController nc = Get.find();
  @override
  void initState() {
    nc.fetchNotifiHistoryActionList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWithoutTabBar(
      title: "Lịch sử hoạt động",
      body: NotificationHistoryActionBody(),
    );
  }
}
