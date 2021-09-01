import 'package:fhcs_mobile_application/controller/batches/batchesController.dart';
import 'package:fhcs_mobile_application/widgets/ScreenShared/screen_without_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/insert_import_batches_body.dart';

class InsertBatchesMedicine extends StatelessWidget {
  const InsertBatchesMedicine({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BatchesMedicineController bmc = Get.find();
    return Obx(() => ScreenWithoutTabBar(
          loadingCall: bmc.isLoadingWait.value,
          title: bmc.showUpdate ? "Cập nhật lô dược phẩm" : "Thêm lô dược phẩm",
          body: InsertBatchesMedicineBody(),
        ));
  }
}
