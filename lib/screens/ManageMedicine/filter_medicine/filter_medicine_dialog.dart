import 'package:fhcs_mobile_application/controller/medicine/medicine_controller.dart';
import 'package:fhcs_mobile_application/data/model/medicineClassification/medicine_classification.dart';
import 'package:fhcs_mobile_application/data/model/medicineSubgroup/medicine_subgroup.dart';
import 'package:fhcs_mobile_application/data/model/medicineUnit/medicine_unit.dart';
import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:fhcs_mobile_application/widgets/Button/rounded_button.dart';
import 'package:fhcs_mobile_application/widgets/DropdownBox/dropdown.dart';
import 'package:fhcs_mobile_application/widgets/Input/boxInput.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterMedicine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MedicineController mc = Get.find();
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.screenHeight * 0.01,
        horizontal: SizeConfig.screenWidth * 0.1,
      ),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Bộ lọc tìm kiếm",
                  style: AppTheme.titleList,
                ),
                IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(
                      Icons.close,
                      color: grey,
                    )),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            BoxInput(
              required: false,
              title: CLASSIFICATION_MEDICINE,
              child: Dropdown(
                  title: "Danh sách loại dược phẩm",
                  listItem: mc.listMedicineClassifications,
                  obj: MedicineClassification,
                  idDropDown: mc.medicineClassificationsIdFilter,
                  itemSelected: mc.medicineClassificationsIdFilter.value,
                  functionSearch: (value) {
                    return mc.fetchClassifications(value);
                  }),
            ),
            BoxInput(
              required: false,
              title: SUBGROUP_MEDICINE,
              child: Dropdown(
                  title: "Danh sách nhóm dược phẩm",
                  listItem: mc.listMedicineSubgroups,
                  obj: MedicineSubgroup,
                  idDropDown: mc.medicineSubGroupIdFilter,
                  itemSelected: mc.medicineSubGroupIdFilter.value,
                  functionSearch: (value) {
                    return mc.fetchSubgroup(value);
                  }),
            ),
            BoxInput(
              required: false,
              title: UNIT_MEDICINE,
              child: Dropdown(
                  title: "Danh sách đơn vị dược phẩm",
                  listItem: mc.listMedicineUnits,
                  obj: MedicineUnit,
                  idDropDown: mc.medicineUnitIdFilter,
                  itemSelected: mc.medicineUnitIdFilter.value,
                  functionSearch: (value) {
                    return mc.fetchUnit(value);
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RoundedButton(
                  text: RESETFILTER,
                  textColor: KPrimaryColor,
                  color: white,
                  press: () {
                    mc.resetTextFilter();
                    mc.refreshList();
                    Get.back();
                  },
                ),
                RoundedButton(
                  text: "Tìm kiếm",
                  press: () {
                    mc.fetchMedicine();
                    Get.back();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
