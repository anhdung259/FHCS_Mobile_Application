import 'package:fhcs_mobile_application/controller/medicine_inventory/medicineInventoryController.dart';
import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:fhcs_mobile_application/widgets/Button/rounded_button.dart';
import 'package:fhcs_mobile_application/widgets/DatePicker/date_picker.dart';
import 'package:fhcs_mobile_application/widgets/Input/background_text_field.dart';
import 'package:fhcs_mobile_application/widgets/Input/boxInput.dart';
import 'package:fhcs_mobile_application/widgets/Input/rounded_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class FilterMedicineInventory extends StatefulWidget {
  @override
  _FilterMedicineInventoryState createState() =>
      _FilterMedicineInventoryState();
}

class _FilterMedicineInventoryState extends State<FilterMedicineInventory> {
  DateTime selectedDate;
  final MedicineInventoryController mic = Get.find();
  @override
  void initState() {
    super.initState();
    if (mic.monthSelect.isNotEmpty) {
      print(mic.monthSelect.value);
      var parts = mic.monthSelect.value.split('/');
      selectedDate =
          DateTime(int.parse(parts[1].trim()), int.parse(parts[0].trim()));
      print(selectedDate);
    } else {
      selectedDate = DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.screenHeight * 0.01,
        horizontal: SizeConfig.screenWidth * 0.1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
          InkWell(
              onTap: () => showMonthPicker(
                    context: context,
                    firstDate: DateTime(DateTime.now().year - 1, 5),
                    lastDate: DateTime(DateTime.now().year + 1, 9),
                    initialDate: selectedDate ?? null,
                    locale: Locale("vi"),
                  ).then((date) {
                    if (date != null) {
                      setState(() {
                        selectedDate = date;
                        mic.selectedDate = date;
                        mic.monthSelect.value =
                            date.month.toString() + "/" + date.year.toString();
                      });
                    }
                  }),
              child: Container(
                  color: white,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BoxInput(
                          required: false,
                          title: "Kỳ nhập(tháng/năm):",
                          child: BackGroundTextField(
                            sizeWidth: getProportionateScreenWidth(135),
                            sizeheight: 60,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        getProportionateScreenWidth(10)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    mic.monthSelect.isNotEmpty
                                        ? Text(
                                            "${selectedDate.month}/${selectedDate.year}",
                                            style: AppTheme.normalText,
                                          )
                                        : Text(
                                            "Tháng/năm",
                                            style: AppTheme.blurred,
                                          ),
                                    Icon(
                                      Icons.event,
                                      color: KPrimaryColor,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        BoxInput(
                          title: "Số lượng:",
                          required: false,
                          child: RoundedInputField(
                            controller: mic.textQuantityFilterController,
                            isNumber: true,
                            sizeWidth: getProportionateScreenWidth(135),
                            hintText: "Nhập số lượng",
                            textInputFormat: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[0-9]+')),
                            ],
                          ),
                        ),
                      ]))),
          BoxInput(
            required: false,
            title: "Ngày nhập:",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DatePick(
                  sizeWidth: getProportionateScreenWidth(135),
                  hintText: DATEFROM,
                  dateNow: mic.fromCreateDateFilter,
                  onChanged: (value) {
                    mic.fromCreateDateFilter = value + " 00:00:00";
                  },
                ),
                DatePick(
                  sizeWidth: getProportionateScreenWidth(135),
                  hintText: DATETO,
                  dateNow: mic.toCreatedDateFilter,
                  onChanged: (value) {
                    mic.toCreatedDateFilter = value + " 23:59:59";
                  },
                ),
              ],
            ),
          ),
          BoxInput(
            required: false,
            title: "Ngày hết hạn:",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DatePick(
                  sizeWidth: getProportionateScreenWidth(135),
                  hintText: DATEFROM,
                  dateNow: mic.fromDateExpirationFilter,
                  onChanged: (value) {
                    mic.fromDateExpirationFilter = value + " 00:00:00";
                  },
                ),
                DatePick(
                  sizeWidth: getProportionateScreenWidth(135),
                  hintText: DATETO,
                  dateNow: mic.toDateExpirationFilter,
                  onChanged: (value) {
                    mic.toDateExpirationFilter = value + " 23:59:59";
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(25),
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
                  mic.resetTextFilter();
                  mic.refreshList();
                  Get.back();
                },
              ),
              RoundedButton(
                text: "Tìm kiếm",
                press: () {
                  mic.fetchMedicineInventory();
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
