import 'package:fhcs_mobile_application/controller/history/historyController.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/widgets/Card/info_line_detail.dart';

import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/widgets/Title/title_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'list_history_treatment_info.dart';

class PatientDetailBody extends StatelessWidget {
  final HistoryController hc = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.screenHeight * 0.05,
        horizontal: SizeConfig.screenWidth * 0.08,
      ),
      child: Obx(
        () => Column(
          children: [
            DisplayDetails(
              title: CODEPATIENT,
              info: hc.patientDetail.value.internalCode ?? NOINFO,
            ),
            DisplayDetails(
              title: NAMEPATIENT,
              info: hc.patientDetail.value.name ?? NOINFO,
            ),
            DisplayDetails(
              title: DEPARTMENT,
              info: hc.patientDetail.value.department.name ?? NOINFO,
            ),
            DisplayDetails(
              title: GENDER,
              info: hc.patientDetail.value.gender == "F" ? "Nữ" : "Nam",
            ),
            DisplayDetails(
              title: ALLERGY,
              info: hc.listAllergyDisplay,
            ),
            TitleList(
              showMore: false,
              title: "Lịch sử khám",
            ),
            ListHistoryTreatmentInfoPatient(),
          ],
        ),
      ),
    );
  }
}
