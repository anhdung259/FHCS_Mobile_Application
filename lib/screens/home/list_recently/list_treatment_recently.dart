import 'package:fhcs_mobile_application/controller/treatment_information/treatmentInfoController.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/widgets/Card/treatment_info_card.dart';
import 'package:fhcs_mobile_application/widgets/List/list_empty.dart';
import 'package:fhcs_mobile_application/widgets/Title/title_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListTreatmentInfoRecently extends StatefulWidget {
  @override
  _ListTreatmentInfoRecentlyState createState() =>
      _ListTreatmentInfoRecentlyState();
}

class _ListTreatmentInfoRecentlyState extends State<ListTreatmentInfoRecently> {
  final TreatmentInfoController tic = Get.find();
  @override
  void initState() {
    tic.fetchTreatmentInfoRecently();
    super.initState();
  }

  Future<void> onEdit(String id) async {
    tic.treatmentId = id;
    tic.getTreatmentDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: SizeConfig.screenHeight * 0.7,
        child: Obx(() {
          if (tic.isLoadingRecent.value)
            return Center(child: CircularProgressIndicator());
          if (tic.listRecently.length == 0) {
            return ListEmpty();
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TitleList(
                title: "Đơn cấp phát gần đây",
                showMore: true,
                optionText: true,
                press: () {
                  Get.toNamed("/treatmentInfoManage");
                },
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: tic.listRecently.length,
                    itemBuilder: (context, index) {
                      return TreatmentCard(
                        treatmentInfoResultSearch: tic.listRecently[index],
                        press: () {
                          onEdit(tic.listRecently[index].id);
                        },
                      );
                    }),
              ),
            ],
          );
        }));
  }
}
