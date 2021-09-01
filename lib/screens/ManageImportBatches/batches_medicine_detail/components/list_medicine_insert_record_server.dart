// import 'package:fhcs_mobile_application/screens/ManagerMedicine/controller/medicine_controller.dart';

import 'package:fhcs_mobile_application/controller/batches/batchesController.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_helper.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/widgets/Card/batches_medicine_record.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListMedicineInImportBatch extends StatefulWidget {
  @override
  _ListMedicineInImportBatchState createState() =>
      _ListMedicineInImportBatchState();
}

class _ListMedicineInImportBatchState extends State<ListMedicineInImportBatch> {
  final BatchesMedicineController bmc = Get.find();

  Future<void> onEdit(String id) async {
    bmc.importMedicineId = id;
    bmc.getDetailImportMedicine();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 500));
    if (bmc.isMoreImportMedicineAvailable.isTrue) {
      bmc.paginateImportMedicine(5);
      _refreshController.loadComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
        height: SizeConfig.screenHeight * 0.54,
        child: SmartRefresher(
          enablePullDown: false,
          enablePullUp: bmc.isMoreImportMedicineAvailable.value,
          controller: _refreshController,
          onLoading: _onLoading,
          child: ListView.builder(
              itemCount: bmc.listImportMedicine.length,
              itemBuilder: (context, index) {
                return BatchesMedicineRecordCard(
                    medicineName: bmc.listImportMedicine[index].name,
                    price: GeneralHelper.formatCurrencyText(
                        bmc.listImportMedicine[index].price.toString()),
                    quantity: bmc.listImportMedicine[index].quantity.toString(),
                    unit: bmc.listImportMedicine[index].medicineUnit.name,
                    status: bmc.listImportMedicine[index].importMedicineStatus
                        .statusImportMedicine,
                    statusId:
                        bmc.listImportMedicine[index].importMedicineStatus.id,
                    dateExpiration: GeneralHelper.formatDateText(
                        bmc.listImportMedicine[index].expirationDate, true),
                    press: () {
                      onEdit(bmc.listImportMedicine[index].id);
                    });
              }),
        )));
  }
}
