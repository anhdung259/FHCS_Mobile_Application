import 'package:fhcs_mobile_application/controller/history/historyController.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/widgets/Card/patient_card.dart';
import 'package:fhcs_mobile_application/widgets/List/list_empty.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListPatient extends StatefulWidget {
  @override
  _ListPatientState createState() => _ListPatientState();
}

class _ListPatientState extends State<ListPatient> {
  final HistoryController hc = Get.find();

  Future<void> onEdit(String id) async {
    hc.patientId = id;
    hc.getDetailPatient();
    // mic.getDetailMeicineInventory();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 500));
    hc.refreshListPatient();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 500));
    if (hc.isMoreDataAvailable.isTrue) {
      hc.paginatePatientList();
      _refreshController.loadComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight * 0.70,
      child: Obx(() {
        if (hc.isLoading.value)
          return Center(child: CircularProgressIndicator());
        if (!hc.isFound.value) {
          return ListEmpty(
            text: NOTFOUND,
          );
        } else if (hc.listPaginationPatient.length == 0) {
          return ListEmpty();
        }
        return SmartRefresher(
          enablePullDown: true,
          enablePullUp: hc.isMoreDataAvailable.value,
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: ListView.builder(
              itemCount: hc.listPaginationPatient.length,
              itemBuilder: (context, index) {
                return PatientCard(
                    patient: hc.listPaginationPatient[index],
                    press: () {
                      onEdit(hc.listPaginationPatient[index].id);
                      // Get.toNamed("/importBatchMedicineDetail");
                    });
              }),
        );
      }),
    );
  }
}
