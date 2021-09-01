import 'package:fhcs_mobile_application/controller/medicine/medicine_controller.dart';
import 'package:fhcs_mobile_application/data/model/allergy/allergy.dart';
import 'package:fhcs_mobile_application/data/model/diagnostic/diagnostic.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_function.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/widgets/Input/boxInput.dart';
import 'package:fhcs_mobile_application/widgets/Input/rounded_input_field.dart';
import 'package:fhcs_mobile_application/widgets/Tagging/tagging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InsertContraindication extends StatefulWidget {
  @override
  _InsertContraindicationState createState() => _InsertContraindicationState();
}

class _InsertContraindicationState extends State<InsertContraindication> {
  final MedicineController mc = Get.find();
  TextEditingController diagnosticController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: getProportionateScreenHeight(400),
        width: getProportionateScreenWidth(300),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Obx(() => BoxInput(
                        title: NAMECONTRAINDICATION,
                        child: RoundedInputField(
                          controller: mc.textNameContraindicationController,
                          line: 1,
                          onChanged: mc.checkDuplicateNameContraindication,
                          error:
                              mc.showNotifiDuplicateNameContraindication.isTrue
                                  ? "Tên này đã tồn tại"
                                  : null,
                        ),
                      )),
                  BoxInput(
                    required: false,
                    title: "Dị ứng chống chỉ định:",
                    child: new Tagging(
                      list: mc.listAllergySelected,
                      findSuggestions: GeneralFunction.fetchAllergyList,
                      hintText: "nhập dị ứng chống chỉ định",
                      onAdded: GeneralFunction.insertNewAllergy,
                      textButton: "Thêm dị ứng",
                      additionCallback: (allergy) {
                        return Allergy(
                          name: allergy,
                        );
                      },
                    ),
                  ),
                  BoxInput(
                    required: false,
                    title: "Bệnh chống chỉ định:",
                    child: new TaggingInsertDiagnosticDialog(
                      list: mc.listDiagnosticCreateNewSelected,
                      findSuggestions: GeneralFunction.fetchDiagnosticList,
                      hintText: "nhập bệnh chống chỉ định ",
                      controller: diagnosticController,
                      insertFunction: () {
                        GeneralFunction.textNameDiagnosticController.text =
                            diagnosticController.text;
                        GeneralFunction.showInsertNewDiagnostic();
                      },
                      onAdded: null,
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
                    title: DESCRIPTION,
                    child: RoundedInputField(
                      controller: mc.textDescriptionContraindicationController,
                      line: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
