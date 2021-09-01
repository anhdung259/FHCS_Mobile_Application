import 'package:fhcs_mobile_application/controller/batches/batchesController.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_helper.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/widgets/Card/batches_medicine_record.dart';
import 'package:fhcs_mobile_application/widgets/List/list_empty.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListMedicineInsertRecord extends StatelessWidget {
  final BatchesMedicineController bmc = Get.find();
  Future<void> onEdit(String id) async {
    bmc.importMedicineId = id;
    bmc.getMedicineInBatchDetailLocal();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // c.refreshList();
      },
      child: Obx(
        () => Container(
            height: SizeConfig.screenHeight * 0.55,
            child: bmc.listMedicineInsertBatchLocal.length > 0
                ? Column(
                    children: [
                      Expanded(
                        child: Scrollbar(
                          child: ListView.builder(
                              // controller: c.scrollController,
                              itemCount:
                                  bmc.listMedicineInsertBatchLocal.length,
                              itemBuilder: (context, index) {
                                return BatchesMedicineRecordCard(
                                    medicineName: bmc
                                        .listMedicineInsertBatchLocal[index]
                                        .name,
                                    price: GeneralHelper.formatCurrencyText(bmc
                                        .listMedicineInsertBatchLocal[index]
                                        .price
                                        .toString()),
                                    quantity: bmc
                                        .listMedicineInsertBatchLocal[index]
                                        .quantity
                                        .toString(),
                                    unit: bmc
                                        .listMedicineInsertBatchLocal[index]
                                        .unit,
                                    dateExpiration:
                                        GeneralHelper.formatDateText(
                                            bmc
                                                .listMedicineInsertBatchLocal[
                                                    index]
                                                .expirationDate,
                                            true),
                                    press: () {
                                      onEdit(bmc
                                          .listMedicineInsertBatchLocal[index]
                                          .id);
                                    });
                              }),
                        ),
                      ),
                      // Container(
                      //   height: c.pagingloading.isTrue ? 50.0 : 0,
                      //   color: Colors.transparent,
                      //   child: Center(
                      //     child: new CircularProgressIndicator(),
                      //   ),
                      // ),
                    ],
                  )
                : ListEmpty()),
      ),
    );
  }
}
