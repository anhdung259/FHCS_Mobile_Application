import 'package:fhcs_mobile_application/controller/medicine/medicine_controller.dart';
import 'package:fhcs_mobile_application/data/model/contraindications/contraindications.dart';
import 'package:fhcs_mobile_application/data/model/diagnostic/diagnostic.dart';
import 'package:fhcs_mobile_application/data/model/medicineClassification/medicine_classification.dart';
import 'package:fhcs_mobile_application/data/model/medicineSubgroup/medicine_subgroup.dart';
import 'package:fhcs_mobile_application/data/model/medicineUnit/medicine_unit.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_function.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_helper.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/widgets/Button/rounded_button.dart';
import 'package:fhcs_mobile_application/widgets/DropdownBox/dropdown.dart';
import 'package:fhcs_mobile_application/widgets/Input/boxInput.dart';
import 'package:fhcs_mobile_application/widgets/Input/rounded_input_field.dart';
import 'package:fhcs_mobile_application/widgets/Tagging/tagging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InsertMedicineBody extends StatefulWidget {
  @override
  _InsertMedicineBodyState createState() => _InsertMedicineBodyState();
}

class _InsertMedicineBodyState extends State<InsertMedicineBody> {
  final MedicineController mc = Get.find();
  FocusNode _focusDiagnostic = new FocusNode();
  FocusNode _focusContraindication = new FocusNode();
  TextEditingController contraindicationController =
      new TextEditingController();
  TextEditingController diagnosticController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    _focusContraindication.addListener(_onFocusChange);
    _focusDiagnostic.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (_focusDiagnostic.hasFocus || _focusContraindication.hasFocus) {
      mc.pushBottom(true);
    } else {
      mc.pushBottom(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.screenHeight * 0.02,
          horizontal: SizeConfig.screenWidth * 0.09,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => BoxInput(
                  title: NAME_MEDICINE,
                  child: Column(
                    children: [
                      RoundedInputField(
                        controller: mc.textNameController,
                        line: 1,
                        onChanged: mc.checkDuplicateNameMedicine,
                        error: mc.showNotifiDuplicateName.isTrue
                            ? "Tên này đã tồn tại"
                            : null,
                      ),
                    ],
                  ),
                )),
            BoxInput(
              required: false,
              title: DESCRIPTION_MEDICINE,
              child: RoundedInputField(
                controller: mc.textDescriptionController,
                line: 2,
              ),
            ),
            BoxInput(
              required: false,
              title: DISEASESTATUSMEDICINE,
              child: new TaggingInsertDiagnosticDialog(
                list: mc.listDiagnosticSelected,
                focus: _focusDiagnostic,
                findSuggestions: GeneralFunction.fetchDiagnosticList,
                hintText: "nhập chỉ định",
                controller: diagnosticController,
                insertFunction: () {
                  GeneralFunction.textNameDiagnosticController.text =
                      diagnosticController.text;
                  GeneralFunction.showInsertNewDiagnostic();
                },
                onAdded: null,
                textButton: "Thêm chẩn đoán",
                additionCallback: (disease) {
                  return Diagnostic(
                    name: disease,
                  );
                },
              ),
            ),
            BoxInput(
              required: false,
              title: CONTRAINDICATION,
              child: TaggingInsertDialog(
                controller: contraindicationController,
                function: () {
                  mc.showNotifiDuplicateNameContraindication(false);
                  mc.textNameContraindicationController.text =
                      contraindicationController.text;
                  mc.showInsertNewContraindication();
                },
                list: mc.listContraindicationSelected,
                focus: _focusContraindication,
                findSuggestions: GeneralFunction.fetchContraindicationList,
                hintText: "nhập chống chỉ định",
                onAdded: null,
                textButton: "Thêm chống chỉ định",
                additionCallback: (contraindication) {
                  return Contraindications(
                    name: contraindication,
                  );
                },
              ),
            ),
            BoxInput(
              title: CLASSIFICATION_MEDICINE,
              child: Dropdown(
                listItem: mc.listMedicineClassifications,
                obj: MedicineClassification,
                idDropDown: mc.medicineClassificationsId,
                itemSelected: mc.medicineClassificationsId.value,
                showClearButton: false,
                press: () => GeneralHelper.showInput(
                    title: "Thêm mới loại dược phẩm",
                    pressOk: () => mc.insertNewClassifiction(),
                    controller: mc.textNewClassificationController,
                    hintText: "tên loại dược phẩm"),
                title: "Danh sách loại dược phẩm",
                functionSearch: (value) {
                  return mc.fetchClassifications(value);
                },
              ),
            ),
            BoxInput(
              title: SUBGROUP_MEDICINE,
              child: Dropdown(
                listItem: mc.listMedicineSubgroups,
                obj: MedicineSubgroup,
                idDropDown: mc.medicineSubGroupId,
                itemSelected: mc.medicineSubGroupId.value,
                showClearButton: false,
                title: "Danh sách nhóm dược",
                press: () => GeneralHelper.showInput(
                    title: "Thêm mới nhóm dược phẩm",
                    pressOk: () => mc.insertNewSubgroup(),
                    controller: mc.textNewSubGroupController,
                    hintText: "tên nhóm dược phẩm"),
                functionSearch: (value) {
                  return mc.fetchSubgroup(value);
                },
              ),
            ),
            BoxInput(
              title: UNIT_MEDICINE,
              child: Dropdown(
                  listItem: mc.listMedicineUnits,
                  obj: MedicineUnit,
                  idDropDown: mc.medicineUnitId,
                  itemSelected: mc.medicineUnitId.value,
                  showClearButton: false,
                  title: "Danh sách đơn vị",
                  press: () {
                    GeneralHelper.showInput(
                        title: "Thêm mới đơn vị dược phẩm",
                        pressOk: () => mc.insertNewUnit(),
                        controller: mc.textNewUnitController,
                        hintText: "tên đơn vị dược phẩm");
                  },
                  functionSearch: (value) {
                    return mc.fetchUnit(value);
                  }),
            ),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            RoundedButton(
              sizeWidth: Get.width,
              text: mc.showUpdate != true ? "Thêm" : "Cập nhật",
              press: () {
                mc.showUpdate != true
                    ? mc.insertNewMedicine()
                    : mc.updateMedicineDetail();
              },
            ),
          ],
        ),
      ),
    );
  }
}
