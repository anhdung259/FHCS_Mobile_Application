import 'package:fhcs_mobile_application/data/model/medicine_export_import_inventory/medicine_export_import_inventory.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_helper.dart';

import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:fhcs_mobile_application/widgets/Card/info_line.dart';
import 'package:fhcs_mobile_application/widgets/ScreenShared/background.dart';
import 'package:flutter/material.dart';

class MedicineExportImportInventoryCard extends StatelessWidget {
  const MedicineExportImportInventoryCard({
    Key key,
    this.medicineExportImportInventory,
  }) : super(key: key);
  final MedicineExportImportInventory medicineExportImportInventory;

  @override
  Widget build(BuildContext context) {
    return BackGroundCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              DisplayInfo(
                widthSize: getProportionateScreenWidth(165),
                title: "Đơn giá: ",
                info: GeneralHelper.formatCurrencyText(
                    medicineExportImportInventory.importMedicine.price
                        .toString()),
                textStyle: AppTheme.titleName,
              ),
              DisplayInfo(
                  widthSize: getProportionateScreenWidth(130),
                  title: "HSD: ",
                  info: GeneralHelper.formatDateText(
                      medicineExportImportInventory
                          .importMedicine.expirationDate,
                      true)),
            ],
          ),
          Row(
            children: [
              DisplayInfo(
                  widthSize: getProportionateScreenWidth(165),
                  title: "SL đầu kỳ: ",
                  info:
                      medicineExportImportInventory.beginInventories.length != 0
                          ? medicineExportImportInventory
                              .beginInventories.single.quantity
                              .toString()
                          : "0"),
              DisplayInfo(
                  widthSize: getProportionateScreenWidth(100),
                  title: "SL xuất: ",
                  info: medicineExportImportInventory.exportMedicines.isNotEmpty
                      ? medicineExportImportInventory
                          .exportMedicines.single.quantity
                          .toString()
                      : "0"),
            ],
          ),
          Row(
            children: [
              DisplayInfo(
                widthSize: getProportionateScreenWidth(165),
                title: "SL nhập: ",
                info: medicineExportImportInventory.importMedicine.quantity
                    .toString(),
              ),
              DisplayInfo(
                widthSize: getProportionateScreenWidth(100),
                title: "SL tồn: ",
                info: medicineExportImportInventory.quantity.toString(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
