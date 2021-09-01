import 'package:fhcs_mobile_application/controller/batches/batchesController.dart';
import 'package:fhcs_mobile_application/data/model/medicine_result_search/medicine_result_search.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_helper.dart';
import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:fhcs_mobile_application/widgets/Button/rounded_button.dart';
import 'package:fhcs_mobile_application/widgets/Card/info_line.dart';
import 'package:fhcs_mobile_application/widgets/DatePicker/date_picker.dart';
import 'package:fhcs_mobile_application/widgets/Input/background_text_field.dart';
import 'package:fhcs_mobile_application/widgets/Input/boxInput.dart';
import 'package:fhcs_mobile_application/widgets/Input/rounded_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

class UpdateInsertRecordLocalMedicineBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BatchesMedicineController bmc = Get.find();
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.screenHeight * 0.06,
          horizontal: SizeConfig.screenWidth * 0.09,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DisplayInfo(
              title: DATE_INSERT_IMPORT_BATCH_MEDICINE,
              info: GeneralHelper.formatDateText(bmc.dateInsert.value, true),
            ),
            BoxInput(
                title: NAME_MEDICINE,
                child: BackGroundTextField(
                  sizeWidth: SizeConfig.screenWidth,
                  child: TypeAheadField<MedicineResultSearch>(
                    hideSuggestionsOnKeyboardHide: false,
                    textFieldConfiguration: TextFieldConfiguration(
                      style: AppTheme.infoPrescription,
                      //  enabled: bmc.enableEdit.value,
                      controller: bmc.textSearhMedicineController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: KPrimaryColor,
                        ),
                        border: InputBorder.none,
                        hintText: SEARCHFIELDMEDICINE,
                      ),
                    ),
                    suggestionsCallback: (pattern) async {
                      return await bmc.getMedicineSuggestions();
                    },
                    itemBuilder: (context, MedicineResultSearch result) {
                      return ListTile(
                        title: Text(
                          result.name,
                          style: AppTheme.infoPrescription,
                        ),
                        // subtitle: Text('$${suggestion['price']}'),
                      );
                    },
                    noItemsFoundBuilder: (context) => Container(
                      height: 100,
                      child: Center(
                        child: Text(
                          'Không tìm thấy dược phẩm nào',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                    onSuggestionSelected: (MedicineResultSearch result) {
                      bmc.textSearhMedicineController.text = result.name;

                      bmc.unitMedicineSelect.value = result.medicineUnit.name;
                      bmc.medicineId = result.id;

                      print(result.id);
                    },
                  ),
                )),
            BoxInput(
                required: false,
                title: DES_IMPORT_BATCH_MEDICINE,
                child: RoundedInputField(
                  controller: bmc.textDesController,
                  line: 2,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BoxInput(
                  title: bmc.unitMedicineSelect.value != ""
                      ? QUATITY_MEDICINE + " (${bmc.unitMedicineSelect.value})"
                      : QUATITY_MEDICINE,
                  child: RoundedInputField(
                    // enableEdit: bmc.enableEdit(),
                    textInputFormat: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
                    ],
                    isNumber: true,
                    controller: bmc.textQuantityController,
                    sizeWidth: getProportionateScreenWidth(140),
                    suffixText: bmc.unitMedicineSelect.value ?? "Viên",
                  ),
                ),
                BoxInput(
                  title: PRICE_IMPORT_BATCH_MEDICINE,
                  child: RoundedInputField(
                    //   enableEdit: bmc.enableEdit(),
                    controller: bmc.textPriceController,
                    isNumber: true,
                    sizeWidth: getProportionateScreenWidth(140),
                    hintText: "0",
                    suffixText: "₫",
                    onChanged: (string) {
                      if (string != "") {
                        string =
                            '${GeneralHelper.formatNumber(string.replaceAll('.', ''))}';

                        bmc.textPriceController.value = TextEditingValue(
                          text: string,
                          selection: TextSelection.collapsed(
                              offset: string.length,
                              affinity: TextAffinity.upstream),
                        );
                      }
                    },
                    textInputFormat: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
                    ],
                  ),
                )
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              BoxInput(
                title: EXPIRATION_DATE_IMPORT_BATCH_MEDICINE,
                child: DatePick(
                  //  enableEdit: bmc.enableEdit(),
                  onChanged: (value) {
                    bmc.dateExpiration.value = value;
                  },
                  dateNow: bmc.dateExpiration.value,
                ),
              ),
              BoxInput(
                title: WARNING_EXPIRATION_DATE_IMPORT_BATCH_MEDICINE,
                child: DatePick(
                  onChanged: (value) {
                    bmc.dateWarningExpiration.value = value;
                  },
                  dateNow: bmc.dateWarningExpiration.value,
                ),
              ),
            ]),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(30)),
              child: Center(
                child: RoundedButton(
                  sizeWidth: Get.width,
                  text: "Cập nhật",
                  press: () {
                    bmc.updateBatch();
                    // bmc.update();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
