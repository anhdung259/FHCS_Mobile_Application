import 'package:fhcs_mobile_application/controller/batches/batchesController.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_helper.dart';
import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:fhcs_mobile_application/widgets/Card/info_line.dart';
import 'package:fhcs_mobile_application/widgets/Card/info_line_detail.dart';
import 'package:fhcs_mobile_application/widgets/Circle/circle_button.dart';
import 'package:fhcs_mobile_application/widgets/ScreenShared/background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'list_medicine_insert_record_server.dart';

class ImportBatchMedicineDetailBody extends StatefulWidget {
  @override
  _ImportBatchMedicineDetailBodyState createState() =>
      _ImportBatchMedicineDetailBodyState();
}

class _ImportBatchMedicineDetailBodyState
    extends State<ImportBatchMedicineDetailBody> {
  final BatchesMedicineController bmc = Get.find();
  @override
  void initState() {
    if (bmc.createNew == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        GeneralHelper.showMessage(
            msg: "Thêm lô nhập thành công", press: () => bmc.createNew = false);
      });

      super.initState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackGroundComponent(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.screenHeight * 0.01,
          horizontal: SizeConfig.screenWidth * 0.03,
        ),
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      DisplayInfo(
                        title: PERIODIC_INVENTORY,
                        info: bmc
                                .importBatchDetail.value.periodicInventory.month
                                .toString() +
                            "/" +
                            bmc.importBatchDetail.value.periodicInventory.year
                                .toString(),
                      ),
                      DisplayInfo(
                          title: DATE_INSERT_IMPORT_BATCH_MEDICINE,
                          info: GeneralHelper.formatDateText(
                              bmc.importBatchDetail.value.createDate, true)),
                      DisplayInfo(
                          title: FINAL_UPDATE,
                          info: GeneralHelper.formatDateText(
                              bmc.importBatchDetail.value.updateDate, true)),
                    ],
                  ),
                  Spacer(),
                  bmc.canUpdate
                      ? Column(
                          children: [
                            CircleButton(
                              backgroundColor: KPrimaryColor,
                              icon: Icons.add,
                              iconColor: white,
                              iconSize: getProportionateScreenHeight(30),
                              onPressed: () {
                                bmc.resetText();
                                Get.toNamed(
                                    "/insertBatchesMedicineRecord?local=false");
                                // mc.navigatorInsertMedicine();
                                // GeneralHelper.navigateToScreen(InsertMedicine(), false);
                              },
                            ),
                            Text(
                              "Thêm dược phẩm ",
                              style: AppTheme.primaryColor,
                            )
                          ],
                        )
                      : Container()
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(30),
              ),
              Text(
                "Danh sách dược phẩm nhập kho",
                style: AppTheme.titleList,
              ),
              SizedBox(
                height: getProportionateScreenHeight(5),
              ),
              ListMedicineInImportBatch(),

              SizedBox(
                height: getProportionateScreenHeight(30),
              ),
              Divider(
                height: 1,
                thickness: 2,
                color: KPrimaryColor,
              ),
              // Spacer(),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),

              Align(
                alignment: Alignment.centerRight,
                child: Column(
                  children: [
                    DisplayDetails(
                      title: QUANTITY_CURRENT,
                      info: "${bmc.numberMedicineInBatch.value} dược phẩm",
                    ),
                    DisplayDetails(
                      title: TOTAL_PRICE,
                      info: GeneralHelper.formatCurrencyText(
                          bmc.totalPrice.value.toString()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // FloatingActionButton(onPressed: onPressed)
    );
  }
}
