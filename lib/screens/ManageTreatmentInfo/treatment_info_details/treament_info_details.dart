import 'package:fhcs_mobile_application/controller/treatment_information/treatmentInfoController.dart';
import 'package:fhcs_mobile_application/widgets/Button/rounded_button.dart';
import 'package:fhcs_mobile_application/widgets/ScreenShared/screen_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/treament_info_details_body.dart';

class TreatmentInfoDetail extends StatelessWidget {
  const TreatmentInfoDetail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TreatmentInfoController tic = Get.find();
    return Obx(() => ScreenDetails(
          title: "Chi tiết đơn cấp phát",
          showEdit: tic.showEdit,
          onEdit: () {
            tic.navigatorUpdateTreatmentDetail();
          },
          showDelete: tic.showRemove,
          onDelete: () {
            tic.showConfirmRemoveTreatmentInfo();
          },
          showFloatingButton: tic.treatmentInformationDetail.value.isDelivered,
          button: RoundedButton(
            text: "Xác nhận đơn cấp phát",
            press: () {
              Get.toNamed("/signature");
            },
          ),
          body: TreatmentInfoDetailsBody(),
        ));
  }
}
