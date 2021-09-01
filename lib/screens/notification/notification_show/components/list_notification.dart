// import 'package:fhcs_mobile_application/screens/ManagerMedicine/controller/medicine_controller.dart';

import 'package:fhcs_mobile_application/controller/notification/notificationController.dart';
import 'package:fhcs_mobile_application/shared/service/push_notification_manager.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/widgets/Card/notifi_card.dart';
import 'package:fhcs_mobile_application/widgets/List/list_empty.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListNotification extends StatefulWidget {
  @override
  _ListNotificationState createState() => _ListNotificationState();
}

class _ListNotificationState extends State<ListNotification> {
  final NotificationController nc = Get.find();

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 500));
    nc.refreshList();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 500));
    if (nc.isMoreDataAvailable.isTrue) {
      nc.pagingNotifiList();
      _refreshController.loadComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight * 0.84,
      child: Obx(() {
        if (nc.isLoading.value)
          return Center(child: CircularProgressIndicator());
        else if (nc.listPaginationNotification.length == 0) {
          return ListEmpty();
        }
        return SmartRefresher(
          enablePullDown: true,
          enablePullUp: nc.isMoreDataAvailable.value,
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: ListView.builder(
              itemCount: nc.listPaginationNotification.length,
              itemBuilder: (context, index) {
                return NotificationCard(
                    notificationServer: nc.listPaginationNotification[index],
                    press: () {
                      print(nc.listPaginationNotification[index].data.entity +
                          "/" +
                          nc.listPaginationNotification[index].data.data);

                      LocalNotificationService.navigartorNotication(
                          nc.listPaginationNotification[index].data,
                          true,
                          nc.listPaginationNotification[index].isClicked,
                          nc.listPaginationNotification[index].id);

                      // Get.toNamed("/importBatchMedicineDetail");
                    });
              }),
        );
      }),
    );
  }
}
