import 'package:fhcs_mobile_application/controller/treatment_information/treatmentInfoController.dart';
import 'package:fhcs_mobile_application/widgets/ScreenShared/screen_without_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/insert_treatment_info_body.dart';

class InsertTreatmentInfo extends StatelessWidget {
  const InsertTreatmentInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TreatmentInfoController tic = Get.find();
    return Obx(() => WillPopScope(
          onWillPop: tic.backScreen,
          child: ScreenWithoutTabBar(
            loadingCall: tic.loadingWait.value,
            title: tic.showEdit == false
                ? "Tạo đơn cấp phát"
                : "Cập nhật đơn cấp phát",
            body: InsertTreatmentInfoBody(),
          ),
        ));
  }
}
