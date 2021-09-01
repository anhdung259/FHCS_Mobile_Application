import 'package:fhcs_mobile_application/controller/batches/batchesController.dart';
import 'package:fhcs_mobile_application/controller/medicine_inventory/medicineInventoryController.dart';
import 'package:fhcs_mobile_application/screens/ManageMedicineInventory/manage_medicine_inventory/components/manage_medicine_inventory_body.dart';
import 'package:fhcs_mobile_application/screens/ManageImportBatches/manage_batches_medicine/screen_tabbar_batch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/manage_import_batch_body.dart';

class BatchesMedicineManage extends StatelessWidget {
  const BatchesMedicineManage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BatchesMedicineController bmc = Get.find();
    final MedicineInventoryController mic = Get.find();
    //final ImportMedicineController imc = Get.find();
    return Obx(() => BatchMedicineManage(
          initialPage: Get.arguments ?? 0,
          loadingCall: mic.loadingWait.value || bmc.isLoadingWait.value,
          title: "Quản lý lô dược phẩm",
          importBatch: BatchesMedicineManagerBody(),
          inventorBatch: MedicineInventoryManageBody(),
          // showFloatingButton: true,
          // button:
        ));
  }
}
