import 'package:fhcs_mobile_application/data/model/medicine_result_search/medicine_result_search.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:fhcs_mobile_application/widgets/Card/info_line.dart';
import 'package:fhcs_mobile_application/widgets/ScreenShared/background.dart';
import 'package:flutter/material.dart';

class MedicineCard extends StatelessWidget {
  const MedicineCard({
    Key key,
    this.press,
    this.medicine,
  }) : super(key: key);
  // final String medicineName;

  // final String medicineClassification;
  // final String pharmaceuticalSubgroup;
  // final int quantity;
  // final String unit;
  final Function press;
  final MedicineResultSearch medicine;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
        press();
      },
      child: BackGroundCard(
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.network(
              MEDICINE,
              height: getProportionateScreenHeight(30),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DisplayInfo(
                  // title: NAME_MEDICINE,
                  info: medicine.name,
                  textStyle: AppTheme.titleName,
                ),
                DisplayInfo(
                    title: "Loại: ",
                    info: medicine.medicineClassification.name),
                DisplayInfo(
                    // widthSize: getProportionateScreenWidth(250),
                    title: "Nhóm: ",
                    info: medicine.medicineSubgroup.name),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
