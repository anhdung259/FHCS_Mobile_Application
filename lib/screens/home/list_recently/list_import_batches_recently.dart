import 'package:fhcs_mobile_application/controller/batches/batchesController.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_helper.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/widgets/Card/import_batches_card%20.dart';
import 'package:fhcs_mobile_application/widgets/List/list_empty.dart';
import 'package:fhcs_mobile_application/widgets/Title/title_list.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListImportBatchesRecently extends StatefulWidget {
  @override
  _ListImportBatchesRecentlyState createState() =>
      _ListImportBatchesRecentlyState();
}

class _ListImportBatchesRecentlyState extends State<ListImportBatchesRecently> {
  final BatchesMedicineController bmc = Get.find();
  @override
  void initState() {
    bmc.fetchImportBatchesRecently();
    super.initState();
  }

  Future<void> onEdit(String id) async {
    bmc.importBatchId = id;
    bmc.getDetailImportBatch();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleList(
          title: "Lô nhập gần đây",
          showMore: true,
          optionText: true,
          press: () {
            bmc.currentIndex.value = 0;
            Get.toNamed("/batchesMedicineManage");
          },
        ),
        Container(
            height: SizeConfig.screenHeight * 0.65,
            child: Obx(() {
              if (bmc.isLoadingRecent.value)
                return Center(child: CircularProgressIndicator());
              if (bmc.listRecently.length == 0) {
                return ListEmpty();
              }
              return ListView.builder(
                  itemCount: bmc.listRecently.length,
                  itemBuilder: (context, index) {
                    return ImportBatchesCard(
                        insertDate: GeneralHelper.formatDateText(
                            bmc.listRecently[index].createDate, true),
                        numberOfMedicine: bmc
                            .listRecently[index].numberOfSpecificMedicine
                            .toString(),
                        totalPrice: GeneralHelper.formatCurrencyText(
                            bmc.listRecently[index].totalPrice.toString()),
                        periodicMonth: bmc
                            .listRecently[index].periodicInventory.month
                            .toString(),
                        periodicYear: bmc
                            .listRecently[index].periodicInventory.year
                            .toString(),
                        press: () {
                          onEdit(bmc.listRecently[index].id);
                          // Get.toNamed("/importBatchMedicineDetail");
                        });
                  });
            })),
      ],
    );
  }
}
