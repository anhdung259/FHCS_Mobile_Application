import 'package:fhcs_mobile_application/controller/medicine/medicine_controller.dart';
import 'package:fhcs_mobile_application/widgets/ScreenShared/screen_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/medicine_detail_body.dart';

class MedicineDetail extends StatelessWidget {
  const MedicineDetail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MedicineController c = Get.find();
    return ScreenDetails(
      loadingCall: c.isLoadingWait.value,
      title: "Chi tiết dược phẩm",
      onEdit: () {
        c.navigatorToUpdate();
      },
      onDelete: () {
        c.showConfirmRemove();
      },
      body: MedicineDetailBody(),
    );
  }
}
