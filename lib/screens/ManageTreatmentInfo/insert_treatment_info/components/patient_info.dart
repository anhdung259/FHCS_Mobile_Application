import 'package:fhcs_mobile_application/controller/treatment_information/treatmentInfoController.dart';
import 'package:fhcs_mobile_application/data/model/allergy/allergy.dart';
import 'package:fhcs_mobile_application/data/model/department/department.dart';
import 'package:fhcs_mobile_application/data/model/diagnostic/diagnostic.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_function.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_helper.dart';
import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:fhcs_mobile_application/widgets/DropdownBox/dropdown.dart';
import 'package:fhcs_mobile_application/widgets/Input/auto_complete_textfiled.dart';
import 'package:fhcs_mobile_application/widgets/Input/boxInput.dart';
import 'package:fhcs_mobile_application/widgets/Input/rounded_input_field.dart';
import 'package:fhcs_mobile_application/widgets/Tagging/tagging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:line_icons/line_icons.dart';

class PatientInfo extends StatefulWidget {
  const PatientInfo({Key key}) : super(key: key);

  @override
  _PatientInfoState createState() => _PatientInfoState();
}

class _PatientInfoState extends State<PatientInfo> {
  final TreatmentInfoController tic = Get.find();
  FocusNode _focusDiagnostic = new FocusNode();
  FocusNode _focusAllergy = new FocusNode();
  TextEditingController controller = new TextEditingController();
  @override
  void initState() {
    super.initState();
    _focusAllergy.addListener(_onFocusChange);
    _focusDiagnostic.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (_focusDiagnostic.hasFocus || _focusAllergy.hasFocus) {
      tic.pushBottom(true);
    } else {
      tic.pushBottom(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
          padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(5),
            horizontal: getProportionateScreenWidth(25),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                BoxInput(
                    title: CODEPATIENT,
                    child: AutoCompleteTextField(
                      focus: false,
                      controller: tic.textCodePatientController,
                      icon: Icon(Icons.qr_code_2),
                      hintText: "",
                      suggestionsCallback: GeneralFunction.fetchPatientList,
                      onSuggestionSelected: (result) {
                        tic.getDetailPatientByInternalCode(result.internalCode);
                        tic.textCodePatientController.text =
                            result.internalCode;
                      },
                      itemBuilder: (context, result) {
                        return ListTile(
                          title: Text(
                            result.internalCode,
                            style: AppTheme.infoPrescription,
                          ),
                          // subtitle: Text('$${suggestion['price']}'),
                        );
                      },
                    )),
                BoxInput(
                  title: NAMEPATIENT,
                  child: RoundedInputField(
                    icon: Icon(LineIcons.userInjured),
                    controller: tic.textNamePatientController,
                  ),
                ),
                Row(
                  children: [
                    Text(GENDER, style: AppTheme.titleDetail),
                    RadioGroup<String>.builder(
                      direction: Axis.horizontal,
                      groupValue: tic.genderSelect.value,
                      onChanged: (value) {
                        tic.genderSelect.value = value;
                      },
                      activeColor: KPrimaryColor,
                      horizontalAlignment: MainAxisAlignment.start,
                      items: tic.gender,
                      itemBuilder: (item) => RadioButtonBuilder(
                        item == "M" ? "Nam" : "Nữ",
                        textPosition: RadioButtonTextPosition.right,
                      ),
                    ),
                  ],
                ),
                BoxInput(
                  title: DEPARTMENT,
                  child: Obx(() => Dropdown(
                        title: "Danh sách phòng ban",
                        listItem: tic.listDepartment,
                        itemSelected: tic.departmentId.value,
                        obj: Department,
                        idDropDown: tic.departmentId,
                        functionSearch: (value) {
                          return tic.fetchDepartmentList(value);
                        },
                        press: () {
                          GeneralHelper.showInput(
                              title: "Thêm mới phòng ban",
                              pressOk: () => tic.insertNewDepartment(),
                              controller: tic.textNewDepartmentController,
                              hintText: "tên phòng ban");
                        },
                      )),
                ),
                BoxInput(
                  required: false,
                  title: ALLERGY,
                  child: new Tagging(
                    list: tic.listAllergySelected,
                    focus: _focusAllergy,
                    findSuggestions: GeneralFunction.fetchAllergyList,
                    hintText: "nhập dị ứng",
                    onAdded: GeneralFunction.insertNewAllergy,
                    textButton: "Thêm dị ứng",
                    function: () {
                      tic.listAllergyFliter.addAll(tic.listAllergySelected
                          .where((a) => tic.listAllergyFliter
                              .every((b) => a.id != b.id)));
                    },
                    additionCallback: (allergy) {
                      return Allergy(
                        name: allergy,
                      );
                    },
                  ),
                ),
                BoxInput(
                  title: DISEASESTATUS,
                  child: RoundedInputField(
                    icon: Icon(
                      Icons.sick,
                      color: grey.withOpacity(0.7),
                    ),
                    controller: tic.textDiseaseStatusPatientController,
                    line: 2,
                  ),
                ),
                BoxInput(
                  title: DIAGNOSTIC,
                  child: new TaggingInsertDiagnosticDialog(
                    list: tic.listDiagnosticSelected,
                    focus: _focusDiagnostic,
                    findSuggestions: GeneralFunction.fetchDiagnosticList,
                    hintText: "nhập chẩn đoán bệnh",
                    controller: controller,
                    insertFunction: () {
                      GeneralFunction.textNameDiagnosticController.text =
                          controller.text;
                      GeneralFunction.showInsertNewDiagnostic();
                    },
                    onAdded: null,
                    textButton: "Thêm chẩn đoán",
                    onChangedFunction: () {
                      tic.listDiagnosticFliter.addAll(tic.listDiagnosticSelected
                          .where((a) => tic.listDiagnosticFliter
                              .every((b) => a.id != b.id)));
                    },
                    additionCallback: (disease) {
                      return Diagnostic(
                        name: disease,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));

    // BoxInput(
    //   title: "Đơn thuốc",
    //   child: ListPrescription(),
  }
}
