import 'package:fhcs_mobile_application/shared/general_helpers/general_function.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/widgets/Input/boxInput.dart';
import 'package:fhcs_mobile_application/widgets/Input/rounded_input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InsertDiagnostic extends StatefulWidget {
  final TextEditingController icdCodecontroller;
  final TextEditingController nameDiagnostic;
  final TextEditingController desController;
  final Function(String) onChangedIcdCode;
  final Function(String) onChangedNameDiagnostic;
  final List<dynamic> listSelected;

  const InsertDiagnostic(
      {Key key,
      this.listSelected,
      this.icdCodecontroller,
      this.nameDiagnostic,
      this.onChangedIcdCode,
      this.onChangedNameDiagnostic,
      this.desController})
      : super(key: key);
  @override
  _InsertDiagnosticState createState() => _InsertDiagnosticState();
}

class _InsertDiagnosticState extends State<InsertDiagnostic> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: getProportionateScreenHeight(250),
        width: getProportionateScreenWidth(300),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() => Column(
                    children: [
                      BoxInput(
                        required: false,
                        title: ICDCODE,
                        child: RoundedInputField(
                          controller: widget.icdCodecontroller,
                          line: 1,
                          onChanged: GeneralFunction.checkDuplicateIcdCode,
                          error:
                              GeneralFunction.showNotifiDuplicateIcdCode.isTrue
                                  ? "Mã ICD này đã tồn tại"
                                  : null,
                        ),
                      ),
                      BoxInput(
                        title: NAMEDIAGNOTIC,
                        child: RoundedInputField(
                          controller: widget.nameDiagnostic,
                          line: 1,
                          onChanged: GeneralFunction.checkDuplicateName,
                          error: GeneralFunction
                                  .showNotifiDuplicateNameDiagnostic.isTrue
                              ? "Tên này đã tồn tại"
                              : null,
                        ),
                      ),
                      BoxInput(
                        required: false,
                        title: DESCRIPTION_MEDICINE,
                        child: RoundedInputField(
                          controller: widget.desController,
                          line: 2,
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
