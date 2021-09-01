import 'package:fhcs_mobile_application/widgets/ScreenShared/screen_without_tabbar.dart';
import 'package:flutter/material.dart';

import 'components/manage_medicine_inventory_body.dart';

class MedicineInventoryManage extends StatelessWidget {
  const MedicineInventoryManage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //  final MedicineInventoryController mic = Get.find();
    return ScreenWithoutTabBar(
      title: "Quản lý dược phẩm",
      body: MedicineInventoryManageBody(),
    );
  }
}
