import 'package:fhcs_mobile_application/controller/treatment_information/treatmentInfoController.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/widgets/Button/filter_button.dart';
import 'package:fhcs_mobile_application/widgets/Input/rounded_input_field.dart';
import 'package:fhcs_mobile_application/widgets/Title/title_list.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import 'list_treatment_info.dart';

class TreatmentInfoManageBody extends StatefulWidget {
  TreatmentInfoManageBody({Key key}) : super(key: key);

  @override
  _TreatmentInfoManageBodyState createState() =>
      _TreatmentInfoManageBodyState();
}

class _TreatmentInfoManageBodyState extends State<TreatmentInfoManageBody> {
  final TreatmentInfoController tic = Get.find();
  @override
  void initState() {
    tic.resetTextFilter();
    tic.fetchTreatmentInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.screenHeight * 0.02,
          horizontal: SizeConfig.screenWidth * 0.07,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedInputField(
                  sizeWidth: getProportionateScreenWidth(257),
                  controller: tic.textSearchTreatmentInfoController,
                  hintText: SEARCHFIELD,
                  icon: Icon(LineIcons.search),
                  // textInputAction: TextInputAction.search,
                  onChanged: (value) => tic.fetchTreatmentInfo(),
                  onSearch: true,
                  press: () {
                    tic.textSearchTreatmentInfoController.clear();
                    tic.fetchTreatmentInfo();
                  },
                ),
                FilterButton(
                  onPress: tic.showDialogFilter,
                ),
              ],
            ),
            TitleList(
              title: "Danh sách đơn cấp phát",
              press: () {
                tic.showDialogFilter();
              },
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            ListTreatmentInfo(),
          ],
        ),
      ),
    );
  }
}
