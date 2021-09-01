import 'package:fhcs_mobile_application/controller/batches/batchesController.dart';
import 'package:fhcs_mobile_application/widgets/ScreenShared/screen_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/batches_medicine_detail_body.dart';

class ImportBatchMedicineDetail extends StatelessWidget {
  const ImportBatchMedicineDetail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BatchesMedicineController bmc = Get.find();
    return ScreenDetails(
      title: "Chi tiết lô nhập",
      showEdit: bmc.canUpdate,
      showDelete: bmc.canUpdate,
      onEdit: () {
        // Get.toNamed("/updateImportBacthMedicine");
        // c.navigatorToUpdate();
        bmc.navigatorUpdateImportBatch();
      },
      onDelete: () {
        bmc.showConfirmRemoveImportBatch();
      },
      body: ImportBatchMedicineDetailBody(),
    );
  }
}
