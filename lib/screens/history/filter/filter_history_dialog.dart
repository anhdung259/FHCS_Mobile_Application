import 'package:fhcs_mobile_application/controller/history/historyController.dart';
import 'package:fhcs_mobile_application/controller/treatment_information/treatmentInfoController.dart';
import 'package:fhcs_mobile_application/data/model/department/department.dart';
import 'package:fhcs_mobile_application/data/model/filter/filter_obj.dart';
import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:fhcs_mobile_application/widgets/Button/rounded_button.dart';
import 'package:fhcs_mobile_application/widgets/DropdownBox/dropdown.dart';
import 'package:fhcs_mobile_application/widgets/Input/boxInput.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterPatientList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HistoryController hc = Get.find();
    final TreatmentInfoController tic = Get.find();
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.screenHeight * 0.01,
        horizontal: SizeConfig.screenWidth * 0.1,
      ),
      child: Column(
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
            title: DEPARTMENT,
            child: Column(
              children: [
                Obx(() => Dropdown(
                      title: "Danh sách phòng ban",
                      listItem: tic.listDepartment,

                      itemSelected: hc.departmentFilter.value,
                      obj: Department,
                      idDropDown: hc.departmentFilter,
                      functionSearch: (value) {
                        return tic.fetchDepartmentList(value);
                      },
                      // press: () {
                    )),
              ],
            ),
          ),
          BoxInput(
            required: false,
            title: GENDER,
            child: Column(
              children: [
                Obx(() => Dropdown(
                      listItem: [
                        FilterObject(display: "Nam", id: "M"),
                        FilterObject(display: "Nữ", id: "F")
                      ],
                      itemSelected: hc.genderFilter.value,
                      obj: FilterObject,
                      idDropDown: hc.genderFilter,
                    )),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RoundedButton(
                text: RESETFILTER,
                textColor: KPrimaryColor,
                color: white,
                press: () {
                  // mc.clearId();
                  hc.resetTextFilter();
                  hc.refreshListPatient();
                  Get.back();
                },
              ),
              RoundedButton(
                text: "Tìm kiếm",
                press: () {
                  hc.fetchPatientList();
                  Get.back();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
