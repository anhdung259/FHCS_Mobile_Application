import 'package:fhcs_mobile_application/controller/notification/notificationController.dart';
import 'package:fhcs_mobile_application/widgets/ScreenShared/screen_without_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/notification_show_body.dart';

class NotificationShow extends StatefulWidget {
  const NotificationShow({Key key}) : super(key: key);

  @override
  _NotificationShowState createState() => _NotificationShowState();
}

class _NotificationShowState extends State<NotificationShow> {
  final NotificationController nc = Get.find();
  @override
  void initState() {
    nc.fetchNotifiList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWithoutTabBar(
      // onCancel: () => Get.back(),
      function: () => nc.currentIndex.value = 0,
      showButtonBack: true,
      title: "Thông báo",
      body: NotificationShowBody(),
    );
  }
}
