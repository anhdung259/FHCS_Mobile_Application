import 'package:fhcs_mobile_application/controller/treatment_information/treatmentInfoController.dart';
import 'package:fhcs_mobile_application/screens/ManageTreatmentInfo/insert_treatment_info/components/confirm_treatment.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/widgets/Button/rounded_button.dart';

import 'package:fhcs_mobile_application/widgets/ScreenShared/screen_without_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmTreatmentInformation extends StatelessWidget {
  const ConfirmTreatmentInformation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TreatmentInfoController tic = Get.find();

    return Obx(() => WillPopScope(
          onWillPop: () {
            //block app from quitting when selecting
            tic.signatureController.clear();
            return Future.value(true);
          },
          child: ScreenWithoutTabBar(
            loadingCall: tic.loadingWait.value,
            title: "Xác nhận đơn cấp phát",
            body: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(5),
                  horizontal: getProportionateScreenWidth(10)),
              child: Column(
                children: [
                  ConfirmTreatment(),
                  RoundedButton(
                    sizeWidth: 250,
                    text: "Xác nhận",
                    press: () {
                      tic.validateConfirm();
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
