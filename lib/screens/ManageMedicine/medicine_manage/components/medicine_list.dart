import 'package:fhcs_mobile_application/controller/medicine/medicine_controller.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/widgets/Card/medicine_card.dart';
import 'package:fhcs_mobile_application/widgets/List/list_empty.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListMedicine extends StatefulWidget {
  @override
  _ListMedicineState createState() => _ListMedicineState();
}

class _ListMedicineState extends State<ListMedicine> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final MedicineController mc = Get.find();
  Future<void> onEdit(String id) async {
    mc.medicineId = id;
    mc.getDetail();
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 500));
    mc.refreshList();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 500));
    if (mc.isMoreDataAvailable.isTrue) {
      mc.paginateList();
      _refreshController.loadComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: SizeConfig.screenHeight * 0.75,
        child: Obx(() {
          if (mc.isLoading.value)
            return Center(child: CircularProgressIndicator());
          else if (!mc.isFound.value) {
            return ListEmpty(
              text: NOTFOUND,
            );
          } else if (mc.listPagination.length == 0) {
            return ListEmpty();
          }
          return SmartRefresher(
            enablePullDown: true,
            enablePullUp: mc.isMoreDataAvailable.value,
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: ListView.builder(
                itemCount: mc.listPagination.length,
                itemBuilder: (context, index) {
                  return MedicineCard(
                    medicine: mc.listPagination[index],
                    press: () {
                      onEdit(mc.listPagination[index].id);
                    },
                  );
                }),
          );
        }));
  }
}
