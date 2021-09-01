import 'package:fhcs_mobile_application/controller/medicine/medicine_controller.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/widgets/Button/filter_button.dart';
import 'package:fhcs_mobile_application/widgets/Input/rounded_input_field.dart';
import 'package:fhcs_mobile_application/widgets/Title/title_list.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import 'medicine_list.dart';

class MedicineManagerBody extends StatelessWidget {
  // const MedicineManagerBody({Key key}) : super(key: key);
  final MedicineController mc = Get.find();
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
              children: [
                RoundedInputField(
                  applyBoxShadow: false,
                  sizeWidth: getProportionateScreenWidth(257),
                  controller: mc.textSearchController,
                  hintText: SEARCHFIELD,
                  // borderColor: KPrimaryColor,
                  icon: Icon(
                    LineIcons.search,
                  ),
                  //  textInputAction: TextInputAction.search,
                  onChanged: (value) => mc.fetchMedicine(),
                  onSearch: true,
                  press: () {
                    mc.textSearchController.clear();
                    mc.fetchMedicine();
                  },
                ),
                FilterButton(
                  onPress: mc.showDialogFilter,
                ),
              ],
            ),
            TitleList(
              title: "Danh sách dược phẩm",
            ),
            ListMedicine(),
          ],
        ),
      ),
    );
  }
}
