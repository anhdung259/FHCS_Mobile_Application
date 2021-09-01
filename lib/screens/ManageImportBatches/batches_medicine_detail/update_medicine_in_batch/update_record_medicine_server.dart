import 'package:fhcs_mobile_application/controller/batches/batchesController.dart';
import 'package:fhcs_mobile_application/widgets/ScreenShared/screen_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/update_record_medicine_server_body.dart';

class UpdateBatchesRecordMedicine extends StatelessWidget {
  const UpdateBatchesRecordMedicine({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BatchesMedicineController bmc = Get.find();
    return ScreenDetails(
      title: "Chi tiết dược phẩm nhập",
      showEdit: bmc.canUpdate,
      showDelete: bmc.canUpdate == true ? bmc.checkShowDelete() : bmc.canUpdate,
      onDelete: () {
        bmc.showConfirmRemoveMedicineInImportBatch();
      },
      onEdit: () {
        bmc.setEnableUpdate();
      },
      body: UpdateBatchesRecordMedicineBody(),
    );
  }
}
