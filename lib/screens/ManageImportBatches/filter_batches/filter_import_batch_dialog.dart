import 'package:fhcs_mobile_application/controller/batches/batchesController.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_helper.dart';
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
import 'package:flutter_range_slider/flutter_range_slider.dart' as frs;

class FilterImportBatch extends StatefulWidget {
  @override
  _FilterImportBatchState createState() => _FilterImportBatchState();
}

class _FilterImportBatchState extends State<FilterImportBatch> {
  DateTime selectedDate;
  final BatchesMedicineController bmc = Get.find();
  @override
  void initState() {
    super.initState();
    if (bmc.monthSelect.isNotEmpty) {
      print(bmc.monthSelect.value);
      var parts = bmc.monthSelect.value.split('/');
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
            title: "Tổng giá(đ):",
            child: Column(
              children: [
                Text(
                  GeneralHelper.formatCurrencyText(
                          bmc.minFilterTotalPrice.round().toString()) +
                      " - " +
                      GeneralHelper.formatCurrencyText(
                          bmc.maxFilterTotalPrice.round().toString()),
                  style: AppTheme.normalText,
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    overlayColor: KPrimaryColor,
                    activeTickMarkColor: KPrimaryColor,
                    activeTrackColor: KPrimaryColor,
                    inactiveTrackColor: KColorBackground,
                    trackHeight: 8,
                    thumbColor: white,
                    overlayShape: RoundSliderOverlayShape(
                      overlayRadius: 30.0,
                    ),
                    thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius: 15,
                      elevation: 2,
                    ),
                  ),
                  child: frs.RangeSlider(
                    min: bmc.minTotalPrice,
                    max: bmc.maxTotalPrice,
                    lowerValue: bmc.minFilterTotalPrice,
                    upperValue: bmc.maxFilterTotalPrice,
                    allowThumbOverlap: true,
                    onChanged: (double newLowerValue, double newUpperValue) {
                      setState(() {
                        bmc.minFilterTotalPrice = newLowerValue;
                        bmc.maxFilterTotalPrice = newUpperValue;
                      });
                    },
                  ),
                ),
              ],
            ),
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
                  bmc.selectedDate = date;
                  bmc.monthSelect.value =
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
                            horizontal: getProportionateScreenWidth(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              bmc.monthSelect.isNotEmpty
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
                    title: "Số thuốc nhập:",
                    required: false,
                    child: RoundedInputField(
                      controller: bmc.textQuantityFilterController,
                      isNumber: true,
                      sizeWidth: getProportionateScreenWidth(135),
                      hintText: "Nhập số lượng",
                      textInputFormat: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          BoxInput(
            required: false,
            title: "Ngày nhập:",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DatePick(
                  sizeWidth: getProportionateScreenWidth(135),
                  hintText: DATEFROM,
                  dateNow: bmc.fromDateFilter,
                  onChanged: (value) {
                    bmc.fromDateFilter = value + " 00:00:00";
                  },
                ),
                DatePick(
                  sizeWidth: getProportionateScreenWidth(135),
                  hintText: DATETO,
                  dateNow: bmc.toDateFilter,
                  onChanged: (value) {
                    bmc.toDateFilter = value + " 23:59:59";
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
                  bmc.resetTextFilter();
                  bmc.refreshList();
                  Get.back();
                },
              ),
              RoundedButton(
                text: "Tìm kiếm",
                press: () {
                  bmc.fetchImportBatch();
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
