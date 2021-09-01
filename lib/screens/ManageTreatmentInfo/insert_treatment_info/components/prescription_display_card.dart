import 'package:fhcs_mobile_application/data/model/treatmentInfo/treatment_info.dart';
import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:fhcs_mobile_application/widgets/Card/info_line.dart';
import 'package:flutter/material.dart';

class PrescriptionDisplayCard extends StatelessWidget {
  const PrescriptionDisplayCard(
      {Key key,
      this.press,
      this.treatmentInfo,
      this.indicateToDrink,
      this.index})
      : super(key: key);

  final TreatmentInfo treatmentInfo;
  final Function press;
  final String indicateToDrink;
  final int index;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(10),
            horizontal: getProportionateScreenWidth(5)),
        padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(5),
            horizontal: getProportionateScreenWidth(5)),
        decoration: BoxDecoration(
          color: white,
          border: Border(
            bottom: BorderSide(color: grey, width: 0.4),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DisplayInfo(
                  title: index.toString() + ". ",
                  widthSize: getProportionateScreenWidth(220),
                  info: treatmentInfo.nameMedicine,
                  textStyle: AppTheme.titleName,
                ),
                DisplayInfo(
                  widthSize: getProportionateScreenWidth(65),
                  info: treatmentInfo.quantity.toString() +
                      "  " +
                      treatmentInfo.unitMedicine,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: getProportionateScreenWidth(15)),
              child: DisplayInfo(
                textStyle: AppTheme.italic,
                widthSize: getProportionateScreenWidth(360),
                info: indicateToDrink,
                overflow: TextOverflow.clip,
              ),
            )
          ],
        ),
      ),
    );
  }
}
