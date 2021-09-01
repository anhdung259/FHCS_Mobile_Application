import 'package:fhcs_mobile_application/controller/medicine/medicine_controller.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/widgets/Card/medicine_export_import_inventory_card.dart';
import 'package:fhcs_mobile_application/widgets/List/list_empty.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListExportImportInventoryMedicince extends StatefulWidget {
  @override
  _ListExportImportInventoryMedicinceState createState() =>
      _ListExportImportInventoryMedicinceState();
}

class _ListExportImportInventoryMedicinceState
    extends State<ListExportImportInventoryMedicince> {
  final MedicineController mc = Get.find();

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 500));
    if (mc.isMoreDataAvailable.isTrue) {
      mc.paginateMedicineExportImportInventoryList();
      _refreshController.loadComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: SizeConfig.screenHeight * 0.44,
        child: Obx(() {
          if (mc.listExportImportInventoryMedicince.length == 0) {
            return ListEmpty();
          }
          return SmartRefresher(
            enablePullDown: false,
            enablePullUp:
                mc.isMoreDataMedicineExportImportInventoryAvailable.value,
            controller: _refreshController,
            onLoading: _onLoading,
            child: ListView.builder(
                controller: mc.scrollControllerMedicineExportImportInventory,
                itemCount: mc.listExportImportInventoryMedicince.length,
                itemBuilder: (context, index) {
                  return MedicineExportImportInventoryCard(
                    medicineExportImportInventory:
                        mc.listExportImportInventoryMedicince[index],
                  );
                }),
          );
        }));
  }
}
