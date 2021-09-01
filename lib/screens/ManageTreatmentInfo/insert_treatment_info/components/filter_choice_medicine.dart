import 'package:fhcs_mobile_application/controller/medicine/medicine_controller.dart';
import 'package:fhcs_mobile_application/controller/treatment_information/treatmentInfoController.dart';
import 'package:fhcs_mobile_application/data/model/allergy/allergy.dart';
import 'package:fhcs_mobile_application/data/model/diagnostic/diagnostic.dart';
import 'package:fhcs_mobile_application/data/model/medicineClassification/medicine_classification.dart';
import 'package:fhcs_mobile_application/data/model/medicineSubgroup/medicine_subgroup.dart';
import 'package:fhcs_mobile_application/data/provider/api_provider.dart';
import 'package:fhcs_mobile_application/data/repository/medicine_repository.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_function.dart';
import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:fhcs_mobile_application/widgets/Button/rounded_button.dart';
import 'package:fhcs_mobile_application/widgets/DropdownBox/dropdown.dart';
import 'package:fhcs_mobile_application/widgets/Input/boxInput.dart';
import 'package:fhcs_mobile_application/widgets/Tagging/tagging.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterChoiceInfo extends StatefulWidget {
  @override
  _FilterChoiceInfoState createState() => _FilterChoiceInfoState();
}

class _FilterChoiceInfoState extends State<FilterChoiceInfo> {
  final TreatmentInfoController tic = Get.find();
  final MedicineController mc = Get.put(MedicineController(
      repository: MedicineRepository(apiClient: ApiProvider())));
  FocusNode _focusDiseaseStatus = new FocusNode();
  FocusNode _focusAllergy = new FocusNode();
  @override
  void initState() {
    super.initState();
    _focusAllergy.addListener(_onFocusChange);
    _focusDiseaseStatus.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (_focusDiseaseStatus.hasFocus || _focusAllergy.hasFocus) {
      tic.pushBottom(true);
    } else {
      tic.pushBottom(false);
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
        children: [
          SingleChildScrollView(
            child: Column(
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
                      idDropDown: tic.medicineClassificationsIdFilter,
                      itemSelected: tic.medicineClassificationsIdFilter.value,
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
                      idDropDown: tic.medicineSubGroupIdFilter,
                      itemSelected: tic.medicineSubGroupIdFilter.value,
                      functionSearch: (value) {
                        return mc.fetchSubgroup(value);
                      }),
                ),
                BoxInput(
                  required: false,
                  title: DIAGNOSTIC,
                  child: new TaggingInsertDiagnosticDialog(
                    list: tic.listDiagnosticFliter,
                    focus: _focusDiseaseStatus,

                    findSuggestions: GeneralFunction.fetchDiagnosticList,
                    hintText: "nhập tình trạng bệnh",
                    //  onAdded: GeneralHelper.insertNewDiagnostic,
                    textButton: "Thêm tình trạng",
                    additionCallback: (disease) {
                      return Diagnostic(
                        name: disease,
                      );
                    },
                  ),
                ),
                BoxInput(
                  required: false,
                  title: ALLERGY,
                  child: new Tagging(
                    list: tic.listAllergyFliter,
                    focus: _focusAllergy,
                    findSuggestions: GeneralFunction.fetchAllergyList,
                    hintText: "nhập dị ứng",
                    onAdded: GeneralFunction.insertNewAllergy,
                    textButton: "Thêm dị ứng",
                    additionCallback: (allergy) {
                      return Allergy(
                        name: allergy,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Obx(() => Padding(
                // this is new
                padding: EdgeInsets.only(
                    bottom: tic.pushBottom.isFalse
                        ? Get.context.mediaQueryViewInsets.bottom
                        : Get.context.mediaQueryViewInsets.bottom +
                            getProportionateScreenHeight(150)),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RoundedButton(
                text: RESETFILTER,
                textColor: KPrimaryColor,
                color: white,
                press: () {
                  // mc.clearId();
                  tic.refreshListChoiceMedicine();
                  Get.back();
                },
              ),
              RoundedButton(
                text: "Tìm kiếm",
                press: () {
                  tic.fetchMedicineChoice();
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
