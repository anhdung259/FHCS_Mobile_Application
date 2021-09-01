import 'package:fhcs_mobile_application/controller/history/historyController.dart';
import 'package:fhcs_mobile_application/widgets/ScreenShared/screen_without_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/history_patient_body.dart';

class HistoryPatient extends StatelessWidget {
  const HistoryPatient({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HistoryController hc = Get.find();
    return ScreenWithoutTabBar(
      loadingCall: hc.loadingWait.value,
      title: "Lịch sử bệnh nhân",
      body: HistoryPatientBody(),
    );
  }
}
