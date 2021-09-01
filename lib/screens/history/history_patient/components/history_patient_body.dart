import 'package:fhcs_mobile_application/controller/history/historyController.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/widgets/Button/filter_button.dart';
import 'package:fhcs_mobile_application/widgets/Input/rounded_input_field.dart';

import 'package:fhcs_mobile_application/widgets/Title/title_list.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'list_patient.dart';

class HistoryPatientBody extends StatelessWidget {
  HistoryPatientBody({Key key}) : super(key: key);
  final HistoryController hc = Get.find();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.screenHeight * 0.02,
          horizontal: SizeConfig.screenWidth * 0.06,
        ),
        child: Column(
          children: [
            Row(
              children: [
                RoundedInputField(
                  sizeWidth: getProportionateScreenWidth(257),
                  controller: hc.textSearchController,
                  hintText: SEARCHFIELD,
                  icon: Icon(LineIcons.search),
                  //  textInputAction: TextInputAction.search,
                  onChanged: (value) => hc.fetchPatientList(),
                  onSearch: true,
                  press: () {
                    hc.textSearchController.clear();
                    hc.fetchPatientList();
                  },
                ),
                FilterButton(
                  onPress: hc.showDialogFilter,
                ),
              ],
            ),
            TitleList(
              title: "Danh sách bệnh nhân",
            ),
            ListPatient(),
          ],
        ),
      ),
    );
  }
}
