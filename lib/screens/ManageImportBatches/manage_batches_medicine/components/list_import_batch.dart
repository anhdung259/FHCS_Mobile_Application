// import 'package:fhcs_mobile_application/screens/ManagerMedicine/controller/medicine_controller.dart';

import 'package:fhcs_mobile_application/controller/batches/batchesController.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_helper.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/widgets/Card/import_batches_card%20.dart';
import 'package:fhcs_mobile_application/widgets/List/list_empty.dart';
import 'package:fhcs_mobile_application/widgets/Title/title_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListImportBatches extends StatefulWidget {
  @override
  _ListImportBatchesState createState() => _ListImportBatchesState();
}

class _ListImportBatchesState extends State<ListImportBatches> {
  final BatchesMedicineController bmc = Get.find();

  @override
  void initState() {
    bmc.resetTextFilter();
    bmc.fetchImportBatch();
    super.initState();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  Future<void> onEdit(String id) async {
    bmc.importBatchId = id;
    bmc.inBatches = true;
    bmc.getDetailImportBatch();
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 500));
    bmc.refreshList();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 500));
    if (bmc.isMoreImportBatchesAvailable.isTrue) {
      bmc.paginateList();
      _refreshController.loadComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleList(
          title: "Danh sách lô nhập",
          showMore: true,
          press: () {
            bmc.showDialogImportBatchesFilter();
          },
        ),
        Container(
          height: SizeConfig.screenHeight * 0.7,
          child: Obx(() {
            if (bmc.isLoading.value)
              return Center(child: CircularProgressIndicator());
            else if (!bmc.isFound.value) {
              return ListEmpty(
                text: NOTFOUND,
              );
            } else if (bmc.listImportBatch.length == 0) {
              return ListEmpty();
            }
            return SmartRefresher(
              enablePullDown: true,
              enablePullUp: bmc.isMoreImportBatchesAvailable.value,
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: ListView.builder(
                  itemCount: bmc.listImportBatch.length,
                  itemBuilder: (context, index) {
                    return ImportBatchesCard(
                        insertDate: GeneralHelper.formatDateText(
                            bmc.listImportBatch[index].createDate, true),
                        numberOfMedicine: bmc
                            .listImportBatch[index].numberOfSpecificMedicine
                            .toString(),
                        totalPrice: GeneralHelper.formatCurrencyText(
                            bmc.listImportBatch[index].totalPrice.toString()),
                        periodicMonth: bmc
                            .listImportBatch[index].periodicInventory.month
                            .toString(),
                        periodicYear: bmc
                            .listImportBatch[index].periodicInventory.year
                            .toString(),
                        press: () {
                          onEdit(bmc.listImportBatch[index].id);
                          // Get.toNamed("/importBatchMedicineDetail");
                        });
                  }),
            );
          }),
        ),
      ],
    );
  }
}
