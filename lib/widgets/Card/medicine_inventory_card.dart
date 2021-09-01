import 'package:fhcs_mobile_application/data/model/medicine_inventory_result_search/medicine_inventory_result_search.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_helper.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:fhcs_mobile_application/widgets/Card/info_line.dart';
import 'package:fhcs_mobile_application/widgets/ScreenShared/background.dart';
import 'package:flutter/material.dart';

class MedicineInventoryCard extends StatelessWidget {
  const MedicineInventoryCard(
      {Key key, this.medicineInventorySearch, this.press})
      : super(key: key);
  final MedicineInventoryResultSearch medicineInventorySearch;
  final Function press;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
        press();
      },
      child: BackGroundCard(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(1),
              horizontal: getProportionateScreenWidth(5)),
          child: Flex(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
            children: [
              Image.network(
                BATCH_MEDICINE_MANAGER,
                height: getProportionateScreenHeight(35),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DisplayInfo(
                    widthSize: SizeConfig.screenWidth * 0.55,
                    //   title: NAME_MEDICINE,
                    info: medicineInventorySearch.name,
                    textStyle: AppTheme.titleName,
                  ),
                  DisplayInfo(
                      title: "Số lượng: ",
                      info: medicineInventorySearch.quantity.toString() +
                          " " +
                          medicineInventorySearch.unitName),
                  DisplayInfo(
                      title: DATE_INSERT_IMPORT_BATCH_MEDICINE,
                      info: GeneralHelper.formatDateText(
                          medicineInventorySearch.insertDate, true)),
                  DisplayInfo(
                      title: EXPIRATION_DATE_IMPORT_BATCH_MEDICINE,
                      info: GeneralHelper.formatDateText(
                          medicineInventorySearch.expirationDate, true))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
