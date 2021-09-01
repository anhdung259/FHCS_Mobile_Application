import 'package:fhcs_mobile_application/controller/treatment_information/treatmentInfoController.dart';
import 'package:fhcs_mobile_application/screens/ManageTreatmentInfo/insert_treatment_info/components/patient_info.dart';
import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/widgets/Button/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im_stepper/stepper.dart';
import 'package:line_icons/line_icons.dart';

import 'confirm_treatment.dart';
import 'make_prescription.dart';

class InsertTreatmentInfoBody extends StatefulWidget {
  @override
  _InsertTreatmentInfoBody createState() => _InsertTreatmentInfoBody();
}

class _InsertTreatmentInfoBody extends State<InsertTreatmentInfoBody> {
  final TreatmentInfoController tic = Get.find();
  var activeStep = 0;
  int upperBound = 2;
  @override
  Widget build(BuildContext context) {
    Widget screen() {
      switch (activeStep) {
        case 0:
          return PatientInfo();
        case 1:
          return MakePrescription();
        case 2:
          return ConfirmTreatment();
        default:
          return PatientInfo();
      }
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Column(
          children: [
            IconStepper(
              steppingEnabled: false,
              activeStepColor: KPrimaryColor,
              icons: [
                Icon(
                  LineIcons.userEdit,
                  color: white,
                ),
                Icon(
                  LineIcons.alternatePrescriptionBottle,
                  color: white,
                ),
                Icon(
                  LineIcons.signature,
                  color: white,
                ),
              ],
              activeStep: activeStep,
              onStepReached: (index) {
                setState(() {
                  activeStep = index;
                });
              },
            ),
            header(),
            Expanded(
              child: screen(),
            ),
            Obx(() => Padding(
                  // this is new
                  padding: EdgeInsets.only(
                      bottom: tic.pushBottom.isFalse
                          ? Get.context.mediaQueryViewInsets.bottom
                          : Get.context.mediaQueryViewInsets.bottom +
                              getProportionateScreenHeight(150)),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                activeStep == 0 ? Container() : previousButton(),
                activeStep == 2 ? createTreatmentInfo() : nextButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String headerText() {
    switch (activeStep) {
      case 0:
        return 'Thông tin bệnh nhân';
      case 1:
        return 'Tạo đơn thuốc';
      case 2:
        return 'Xác nhận đơn cấp phát';
      default:
        return 'Thông tin bệnh nhân';
    }
  }

  Widget nextButton() {
    return RoundedButton(
      sizeHeight: getProportionateScreenHeight(40),
      text: "Tiếp tục",
      press: () {
        FocusScope.of(context).unfocus();
        if (activeStep < upperBound) {
          if (activeStep == 0 && tic.validatePatientInfo()) {
            setState(() {
              activeStep++;
            });
          } else if (activeStep == 1 && tic.validatePerscription()) {
            setState(() {
              activeStep++;
            });
          }
        }
      },
    );
  }

  Widget previousButton() {
    return RoundedButton(
      sizeHeight: getProportionateScreenHeight(38),
      text: "Trở lại",
      press: () {
        FocusScope.of(context).unfocus();
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        }
      },
    );
  }

  Widget createTreatmentInfo() {
    return tic.showEdit == false
        ? RoundedButton(
            sizeHeight: getProportionateScreenHeight(38),
            text: "Tạo đơn",
            press: () {
              FocusScope.of(context).unfocus();
              tic.validateInsert();
            },
          )
        : RoundedButton(
            sizeHeight: getProportionateScreenHeight(38),
            text: "Cập nhật",
            press: () {
              FocusScope.of(context).unfocus();
              tic.validateUpdate();
            });
  }

  Widget header() {
    return Container(
      decoration: BoxDecoration(
        color: KPrimaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              headerText(),
              style: TextStyle(
                color: white,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
