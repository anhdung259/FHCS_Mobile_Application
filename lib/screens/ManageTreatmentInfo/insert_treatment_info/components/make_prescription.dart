import 'package:fhcs_mobile_application/controller/treatment_information/treatmentInfoController.dart';
import 'package:fhcs_mobile_application/screens/ManageTreatmentInfo/insert_treatment_info/components/prescription_making_card.dart';
import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:fhcs_mobile_application/widgets/Button/rounded_button.dart';
import 'package:fhcs_mobile_application/widgets/List/list_empty.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MakePrescription extends StatelessWidget {
  final TreatmentInfoController tic = Get.find();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(
        () => Container(
          height: Get.height * 0.83,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenHeight(5),
                      horizontal: getProportionateScreenWidth(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Đơn thuốc",
                        style: AppTheme.titleTable,
                      ),
                      RoundedButtonInsert(
                        sizeHeight: 40,
                        sizeWidth: 130,
                        textColor: KPrimaryColor,
                        color: white,
                        text: "Chọn thuốc",
                        press: () {
                          tic.showMultiSelect();
                          tic.medicineInventorySearchList.clear();
                          tic.medicineId = "";
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                thickness: 1,
              ),
              tic.listPrescription.length != 0
                  ? Expanded(
                      child: ListView.builder(
                          // controller: mc.scrollController,
                          itemCount: tic.listPrescription.length,
                          itemBuilder: (context, index) {
                            return PrescriptionMakingCard(
                              onEdit: () {
                                tic.medicineId =
                                    tic.listPrescription[index].medicineId;
                                tic.showMultiSelectUpdate(
                                    tic.listPrescription[index].medicineId);
                              },
                              onDelete: () {
                                tic.medicineId =
                                    tic.listPrescription[index].medicineId;
                                tic.prescriptionId =
                                    tic.listPrescription[index].id;
                                tic.showConfirmDeletePrescription();
                              },
                              treatmentInfo: tic.listPrescription[index],
                              textController:
                                  tic.indicationToDrinkController[index],
                              // indicateToDrink:,
                            );
                          }),
                    )
                  : Expanded(
                      child: Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ListEmpty(),
                            ]),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
    // );
  }
}
