import 'package:fhcs_mobile_application/controller/batches/batchesController.dart';
import 'package:fhcs_mobile_application/screens/ManageImportBatches/insert_import_batches/components/update_insert_record_medicine_local_body.dart';
import 'package:fhcs_mobile_application/widgets/ScreenShared/screen_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateInsertRecordLocalMedicine extends StatelessWidget {
  const UpdateInsertRecordLocalMedicine({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BatchesMedicineController bmc = Get.find();
    return ScreenDetails(
      title: "Chi tiết",
      onDelete: () {
        print("addd");
        bmc.showConfirmRemove();
      },
      showEdit: false,
      // onEdit: () {
      //   bmc.setEnableUpdate();
      // },
      body: UpdateInsertRecordLocalMedicineBody(),
    );
  }
}
