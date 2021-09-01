import 'package:fhcs_mobile_application/controller/history/historyController.dart';
import 'package:fhcs_mobile_application/controller/treatment_information/treatmentInfoController.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/widgets/Card/treatment_info_card.dart';
import 'package:fhcs_mobile_application/widgets/List/list_empty.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListHistoryTreatmentInfoPatient extends StatefulWidget {
  @override
  _ListHistoryTreatmentInfoPatientState createState() =>
      _ListHistoryTreatmentInfoPatientState();
}

class _ListHistoryTreatmentInfoPatientState
    extends State<ListHistoryTreatmentInfoPatient> {
  final HistoryController hc = Get.find();

  final TreatmentInfoController tic = Get.find();

  Future<void> onEdit(String id) async {
    tic.treatmentId = id;
    tic.getTreatmentDetail();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 500));
    if (hc.isMoreListHistoryPatient.isTrue) {
      hc.paginateListHistoryTreatmentInfoPatient();
      _refreshController.loadComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: SizeConfig.screenHeight * 0.53,
        child: Obx(() {
          if (hc.isLoading.value)
            return Center(child: CircularProgressIndicator());

          if (!hc.isFound.value) {
            return ListEmpty();
          }
          if (hc.listHistoryPatient.length == 0) {
            return ListEmpty();
          }

          return SmartRefresher(
              enablePullDown: false,
              enablePullUp: hc.isMoreListHistoryPatient.value,
              controller: _refreshController,
              onLoading: _onLoading,
              child: ListView.builder(
                  itemCount: hc.listHistoryPatient.length,
                  itemBuilder: (context, index) {
                    return TreatmentCard(
                      press: () => onEdit(hc.listHistoryPatient[index].id),
                      treatmentInfoResultSearch: hc.listHistoryPatient[index],
                    );
                  })
              //  verticalDirection: VerticalDirection.down,
              );
        }));
  }
}
