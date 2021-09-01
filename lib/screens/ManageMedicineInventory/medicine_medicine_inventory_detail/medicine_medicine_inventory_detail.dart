import 'package:fhcs_mobile_application/controller/medicine_inventory/medicineInventoryController.dart';
import 'package:fhcs_mobile_application/widgets/ScreenShared/screen_without_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/medicine_medicine_inventory_detail_body.dart';

class MedicineInventoryDetail extends StatelessWidget {
  const MedicineInventoryDetail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MedicineInventoryController mic = Get.find();
    return Obx(() => ScreenWithoutTabBar(
          title: "Chi tiết dược phẩm tồn",
          loadingCall: mic.loadingWait.value,
          body: MedicineInventoryDetailBody(),
        ));
  }
}
