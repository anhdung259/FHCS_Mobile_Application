import 'package:fhcs_mobile_application/controller/treatment_information/treatmentInfoController.dart';
import 'package:fhcs_mobile_application/data/model/department/department.dart';
import 'package:fhcs_mobile_application/data/model/filter/filter_obj.dart';
import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:fhcs_mobile_application/widgets/Button/rounded_button.dart';
import 'package:fhcs_mobile_application/widgets/DatePicker/date_picker.dart';
import 'package:fhcs_mobile_application/widgets/DropdownBox/dropdown.dart';
import 'package:fhcs_mobile_application/widgets/Input/boxInput.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterTreatmentInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TreatmentInfoController tic = Get.find();
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.screenHeight * 0.01,
        horizontal: SizeConfig.screenWidth * 0.1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
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
            title: "Khoảng thời gian",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DatePick(
                  sizeWidth: getProportionateScreenWidth(135),
                  hintText: DATEFROM,
                  dateNow: tic.fromDateFilter,
                  onChanged: (value) {
                    tic.fromDateFilter = value + " 00:00:00";
                  },
                ),
                DatePick(
                  sizeWidth: getProportionateScreenWidth(135),
                  hintText: DATETO,
                  dateNow: tic.toDateFilter,
                  onChanged: (value) {
                    tic.toDateFilter = value + " 23:59:59";
                  },
                ),
              ],
            ),
          ),
          BoxInput(
            required: false,
            title: DEPARTMENT,
            child: Column(
              children: [
                Obx(() => Dropdown(
                      title: "Danh sách phòng ban",
                      listItem: tic.listDepartment,
                      itemSelected: tic.departmentFilter.value,
                      obj: Department,
                      idDropDown: tic.departmentFilter,
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
                      title: "Giới tính",
                      listItem: [
                        FilterObject(display: "Nam", id: "M"),
                        FilterObject(display: "Nữ", id: "F")
                      ],
                      itemSelected: tic.genderFilter.value,
                      obj: FilterObject,
                      idDropDown: tic.genderFilter,
                    )),
              ],
            ),
          ),
          BoxInput(
            required: false,
            title: STATUSTREATMENT,
            child: Column(
              children: [
                Obx(() => Dropdown(
                      title: "Trạng thái đơn cấp phát",
                      listItem: [
                        FilterObject(display: "Chưa xác nhận", id: "false"),
                        FilterObject(display: "Đã xác nhận", id: "true")
                      ],
                      itemSelected: tic.isDeliveredFilter.value,
                      obj: FilterObject,
                      idDropDown: tic.isDeliveredFilter,
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
                  tic.resetTextFilter();
                  tic.refreshList();
                  Get.back();
                },
              ),
              RoundedButton(
                text: "Tìm kiếm",
                press: () {
                  tic.fetchTreatmentInfo();
                  Get.back();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
