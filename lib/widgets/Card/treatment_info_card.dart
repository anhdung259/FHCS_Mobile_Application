import 'package:fhcs_mobile_application/data/model/treatment_info_result_search/treatment_info_result_search.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_helper.dart';
import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:flutter/material.dart';

import 'info_line.dart';

class TreatmentCard extends StatelessWidget {
  const TreatmentCard({Key key, this.press, this.treatmentInfoResultSearch})
      : super(key: key);

  final Function press;
  final TreatmentInfoResultSearch treatmentInfoResultSearch;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
        press();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: grey, width: 0.5),
          ),
        ),
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(16),
            vertical: getProportionateScreenHeight(5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DisplayInfo(
                  widthSize: SizeConfig.screenWidth * 0.52,
                  title: NAMEPATIENT,
                  info: treatmentInfoResultSearch.patientName,
                  textStyle: AppTheme.titleName,
                ),
                Text(
                  GeneralHelper.formatDateText(
                      treatmentInfoResultSearch.createAt, true),
                  style: AppTheme.selectBox,
                ),
              ],
            ),
            DisplayInfo(
              widthSize: SizeConfig.screenWidth * 0.6,
              title: DEPARTMENT,
              info: treatmentInfoResultSearch.departmentName,
            ),
            DisplayInfo(
              title: STATUSTREATMENT,
              info: treatmentInfoResultSearch.isDelivered == true
                  ? "Đã xác nhận"
                  : "Chưa xác nhận",
              textStyle: TextStyle(
                  color: treatmentInfoResultSearch.isDelivered == true
                      ? success
                      : waring,
                  fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
