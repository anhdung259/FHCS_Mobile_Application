import 'package:fhcs_mobile_application/controller/treatment_information/treatmentInfoController.dart';
import 'package:fhcs_mobile_application/data/model/treatmentInfo/treatment_info.dart';
import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:fhcs_mobile_application/widgets/Card/info_line.dart';
import 'package:fhcs_mobile_application/widgets/Input/boxInput.dart';
import 'package:fhcs_mobile_application/widgets/Input/rounded_input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrescriptionMakingCard extends StatelessWidget {
  const PrescriptionMakingCard(
      {Key key,
      this.press,
      this.treatmentInfo,
      this.textController,
      this.indicateToDrink,
      this.onEdit,
      this.onDelete,
      this.index})
      : super(key: key);

  final TreatmentInfo treatmentInfo;
  final TextEditingController textController;
  final Function press;
  final String indicateToDrink;
  final Function onEdit;
  final Function onDelete;
  final int index;
  @override
  Widget build(BuildContext context) {
    final TreatmentInfoController tic = Get.find();
    return InkWell(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(10),
            horizontal: getProportionateScreenWidth(7)),
        padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(1),
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
                  widthSize: getProportionateScreenWidth(280),
                  title: "",
                  info: treatmentInfo.nameMedicine,
                  textStyle: AppTheme.titleName,
                ),
                Container(
                  width: getProportionateScreenWidth(30),
                  child: InkWell(
                    onTap: onEdit,
                    child: Icon(
                      Icons.edit,
                      size: getProportionateScreenHeight(20),
                      color: grey,
                    ),
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenHeight(15),
                ),
                InkWell(
                  onTap: onDelete,
                  child: Icon(
                    Icons.delete,
                    size: getProportionateScreenHeight(20),
                    color: grey,
                  ),
                )
              ],
            ),
            DisplayInfo(
              title: QUATITY_MEDICINE_EXPORT,
              info: treatmentInfo.quantity.toString() +
                  " " +
                  treatmentInfo.unitMedicine,
            ),
            BoxInput(
              title: INDICATIONTODRINK,
              child: RoundedInputField(
                applyBoxShadow: false,
                borderColor: grey,
                controller: textController,
                onChanged: (value) {
                  tic.listPrescription
                      .where((e) => e.id == treatmentInfo.id)
                      .first
                      .indicationToDrink = textController.text;
                },
                line: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
