// import 'package:fhcs_mobile_application/screens/ManagerMedicine/controller/medicine_controller.dart';

import 'package:fhcs_mobile_application/controller/medicine_inventory/medicineInventoryController.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/widgets/Card/medicine_inventory_card.dart';
import 'package:fhcs_mobile_application/widgets/List/list_empty.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListMedicineInventory extends StatefulWidget {
  @override
  _ListMedicineInventoryState createState() => _ListMedicineInventoryState();
}

class _ListMedicineInventoryState extends State<ListMedicineInventory> {
  final MedicineInventoryController mic = Get.find();

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 500));
    mic.refreshList();
    _refreshController.refreshCompleted();
  }

  Future<void> onEdit(String id) async {
    mic.medicineInventoryDetailId = id;
    mic.getDetailMeicineInventory();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 500));
    if (mic.isMoreDataAvailable.isTrue) {
      mic.paginateList();
      _refreshController.loadComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight * 0.7,
      child: Obx(() {
        if (mic.isLoading.value)
          return Center(child: CircularProgressIndicator());
        if (!mic.isFound.value) {
          return ListEmpty(
            text: NOTFOUND,
          );
        } else if (mic.listPagination.length == 0) {
          return ListEmpty();
        }
        return SmartRefresher(
          enablePullDown: true,
          enablePullUp: mic.isMoreDataAvailable.value,
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: ListView.builder(
              itemCount: mic.listPagination.length,
              itemBuilder: (context, index) {
                return MedicineInventoryCard(
                    medicineInventorySearch: mic.listPagination[index],
                    press: () {
                      onEdit(mic.listPagination[index].id);
                      // Get.toNamed("/importBatchMedicineDetail");
                    });
              }),
        );
      }),
    );
  }
}
