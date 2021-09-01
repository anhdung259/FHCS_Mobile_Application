import 'package:fhcs_mobile_application/controller/medicine_inventory/medicineInventoryController.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_helper.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/widgets/Button/rounded_button.dart';
import 'package:fhcs_mobile_application/widgets/Card/info_line_detail.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicineInventoryDetailBody extends StatelessWidget {
  final MedicineInventoryController mic = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.screenHeight * 0.03,
          horizontal: SizeConfig.screenWidth * 0.07,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DisplayDetails(
              title: NAME_MEDICINE,
              info: mic.medicineInventoryDetail.value.medicine.name ?? NOINFO,
            ),
            DisplayDetails(
              title: QUATITY_MEDICINE,
              info: mic.medicineInventoryDetail.value.quantity.toString() +
                      " " +
                      mic.medicineInventoryDetail.value.medicineUnit.name ??
                  NOINFO,
            ),
            DisplayDetails(
              title: PRICE_IMPORT_BATCH_MEDICINE,
              info: GeneralHelper.formatCurrencyText(mic
                      .medicineInventoryDetail.value.importMedicine.price
                      .toString()) ??
                  NOINFO,
            ),
            DisplayDetails(
              title: CLASSIFICATION_MEDICINE,
              info: mic.medicineInventoryDetail.value.medicineClassification
                      .name ??
                  NOINFO,
            ),
            DisplayDetails(
              title: SUBGROUP_MEDICINE,
              info:
                  mic.medicineInventoryDetail.value.medicineUnit.name ?? NOINFO,
            ),
            DisplayDetails(
                title: PERIODIC_INVENTORY,
                info: mic.medicineInventoryDetail.value.periodicInventory.month
                            .toString() +
                        "/" +
                        mic.medicineInventoryDetail.value.periodicInventory.year
                            .toString() ??
                    NOINFO),
            DisplayDetails(
              title: DATE_INSERT_IMPORT_BATCH_MEDICINE,
              info: GeneralHelper.formatDateText(
                      mic.medicineInventoryDetail.value.importMedicine
                          .insertDate,
                      true) ??
                  NOINFO,
            ),
            DisplayDetails(
              title: EXPIRATION_DATE_IMPORT_BATCH_MEDICINE,
              info: GeneralHelper.formatDateText(
                      mic.medicineInventoryDetail.value.importMedicine
                          .expirationDate,
                      true) ??
                  NOINFO,
            ),

            // DisplayDetails(
            //   title: DATA_CREATE,
            //   info: formatDate(dateTime, [dd, '-', mm, '-', yyyy]),
            // ),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            mic.canUpdate && mic.medicineInventoryDetail.value.quantity > 0
                ? Center(
                    child: RoundedButton(
                      sizeWidth: Get.width,
                      text: "Hủy dược phẩm",
                      press: () {
                        mic.showDialogEliminateMedicine();
                        // c.insertNewMedicine();
                        // mc.validateInsertMedicine();
                      },
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
