import 'package:fhcs_mobile_application/controller/batches/batchesController.dart';
import 'package:fhcs_mobile_application/controller/batches/importMedicineController.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_helper.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/widgets/Card/batches_medicine_record.dart';
import 'package:fhcs_mobile_application/widgets/List/list_empty.dart';
import 'package:fhcs_mobile_application/widgets/Title/title_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListImportMedicineRecently extends StatefulWidget {
  @override
  _ListImportMedicineRecentlyState createState() =>
      _ListImportMedicineRecentlyState();
}

class _ListImportMedicineRecentlyState
    extends State<ListImportMedicineRecently> {
  final ImportMedicineController imc = Get.find();
  final BatchesMedicineController bmc = Get.find();

  @override
  void initState() {
    imc.fetchImportMedicineRecently();
    super.initState();
  }

  Future<void> onEdit(String id) async {
    bmc.importMedicineId = id;
    bmc.getDetailImportMedicine();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: SizeConfig.screenHeight * 0.7,
        child: Obx(() {
          if (imc.isLoadingRecent.value)
            return Center(child: CircularProgressIndicator());
          if (imc.listRecently.length == 0) {
            return ListEmpty();
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TitleList(
                title: "Dược phẩm nhập gần đây",
                showMore: true,
                optionText: true,
                press: () {
                  bmc.currentIndex.value = 1;
                  Get.toNamed("/batchesMedicineManage");
                },
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: imc.listRecently.length,
                    itemBuilder: (context, index) {
                      return BatchesMedicineRecordCard(
                          medicineName: imc.listRecently[index].name,
                          price: GeneralHelper.formatCurrencyText(
                              imc.listRecently[index].price.toString()),
                          quantity: imc.listRecently[index].quantity.toString(),
                          unit: imc.listRecently[index].medicineUnit.name,
                          status: imc.listRecently[index].importMedicineStatus
                              .statusImportMedicine,
                          statusId:
                              imc.listRecently[index].importMedicineStatus.id,
                          dateExpiration: GeneralHelper.formatDateText(
                              imc.listRecently[index].expirationDate, true),
                          press: () {
                            onEdit(imc.listRecently[index].id);
                          });
                    }),
              ),
            ],
          );
        }));
  }
}
