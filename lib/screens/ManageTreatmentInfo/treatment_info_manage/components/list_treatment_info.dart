import 'package:fhcs_mobile_application/controller/treatment_information/treatmentInfoController.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/widgets/Card/treatment_info_card.dart';
import 'package:fhcs_mobile_application/widgets/List/list_empty.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListTreatmentInfo extends StatefulWidget {
  @override
  _ListTreatmentInfoState createState() => _ListTreatmentInfoState();
}

class _ListTreatmentInfoState extends State<ListTreatmentInfo> {
  final TreatmentInfoController tic = Get.find();

  Future<void> onEdit(String id) async {
    tic.treatmentId = id;
    tic.getTreatmentDetail();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 500));
    tic.refreshList();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 500));
    if (tic.isMoreTreatmentInfoAvailable.isTrue) {
      tic.paginateList();
      _refreshController.loadComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: SizeConfig.screenHeight * 0.75,
        child: Obx(() {
          if (tic.isLoading.value)
            return Center(child: CircularProgressIndicator());

          if (!tic.isFound.value) {
            return ListEmpty(
              text: NOTFOUND,
            );
          }
          if (tic.listPaginationTreament.length == 0) {
            return ListEmpty();
          }
          return SmartRefresher(
            enablePullDown: true,
            enablePullUp: tic.isMoreTreatmentInfoAvailable.value,
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: ListView.builder(
                itemCount: tic.listPaginationTreament.length,
                itemBuilder: (context, index) {
                  return TreatmentCard(
                    treatmentInfoResultSearch:
                        tic.listPaginationTreament[index],
                    press: () {
                      onEdit(tic.listPaginationTreament[index].id);
                    },
                  );
                }),
          );
        }));
  }
}
