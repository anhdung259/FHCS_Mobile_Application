import 'package:fhcs_mobile_application/controller/treatment_information/treatmentInfoController.dart';
import 'package:fhcs_mobile_application/widgets/Button/create_new_button.dart';
import 'package:fhcs_mobile_application/widgets/ScreenShared/screen_without_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/treatment_info_manage_body.dart';

class TreatmentInfoManage extends StatelessWidget {
  const TreatmentInfoManage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TreatmentInfoController tic = Get.find();
    return ScreenWithoutTabBar(
      title: "Quản lý đơn cấp phát",
      showFloatingButton: true,
      button: CreatNewButton(
        onPress: () {
          FocusScope.of(context).unfocus();
          tic.showEdit = false;
          tic.getTimeNow();
          Get.toNamed("/insertTreatmentInfo");
        },
      ),
      body: TreatmentInfoManageBody(),
    );
  }
}
