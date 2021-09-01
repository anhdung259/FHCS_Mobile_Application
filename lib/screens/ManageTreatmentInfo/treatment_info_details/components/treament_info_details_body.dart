import 'package:fhcs_mobile_application/controller/treatment_information/treatmentInfoController.dart';
import 'package:fhcs_mobile_application/data/model/treatmentInfo/treatment_info.dart';
import 'package:fhcs_mobile_application/screens/ManageTreatmentInfo/insert_treatment_info/components/prescription_display_card.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_helper.dart';
import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:fhcs_mobile_application/widgets/Card/info_line_detail.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TreatmentInfoDetailsBody extends StatefulWidget {
  const TreatmentInfoDetailsBody({Key key}) : super(key: key);

  @override
  _TreatmentInfoDetailsBodyState createState() =>
      _TreatmentInfoDetailsBodyState();
}

class _TreatmentInfoDetailsBodyState extends State<TreatmentInfoDetailsBody> {
  final TreatmentInfoController tic = Get.find();
  @override
  void initState() {
    super.initState();
    if (tic.showWarningQuantity == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        GeneralHelper.showMessage(
            msg: tic.medicineNameWarning + " không đủ số lượng.");
      });
    }
    if (tic.createNew == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        GeneralHelper.showMessage(
            msg: "Tạo đơn cấp phát thành công",
            press: () => tic.createNew = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: SizeConfig.screenHeight * 0.02,
            horizontal: SizeConfig.screenWidth * 0.08,
          ),
          child: Column(
            children: [
              DisplayDetails(
                title: DATECREATE,
                info: GeneralHelper.formatDateText(
                        tic.treatmentInformationDetail.value.createAt, true) ??
                    NOINFO,
              ),
              DisplayDetails(
                title: CODEPATIENT,
                info:
                    tic.treatmentInformationDetail.value.patient.internalCode ??
                        NOINFO,
              ),
              DisplayDetails(
                title: NAMEPATIENT,
                textStyle: AppTheme.highlight,
                info:
                    tic.treatmentInformationDetail.value.patient.name ?? NOINFO,
              ),
              DisplayDetails(
                title: DEPARTMENT,
                info: tic.treatmentInformationDetail.value.departmentName ??
                    NOINFO,
              ),
              DisplayDetails(
                title: GENDER,
                info: tic.treatmentInformationDetail.value.patient.gender == "F"
                    ? "Nữ"
                    : "Nam",
              ),
              DisplayDetails(
                  title: ALLERGY, info: tic.listAllergyDisplay.value),
              DisplayDetails(
                title: DISEASESTATUS,
                info: tic.treatmentInformationDetail.value.diseaseStatuses ??
                    NOINFO,
              ),
              DisplayDetails(
                  textStyle: AppTheme.highlight,
                  title: DIAGNOSTIC,
                  info: tic.listDiagnosticDisplay.value),
              SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Thuốc cấp phát:",
                    style: AppTheme.titleDetail,
                  ),
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: tic.treatmentInformationDetail.value
                          .treatmentInformations.length,
                      itemBuilder: (context, index) {
                        return PrescriptionDisplayCard(
                          index: index + 1,
                          treatmentInfo: TreatmentInfo(
                              nameMedicine: tic.treatmentInformationDetail.value
                                  .treatmentInformations[index].medicine.name,
                              unitMedicine: tic
                                  .treatmentInformationDetail
                                  .value
                                  .treatmentInformations[index]
                                  .medicine
                                  .medicineUnit
                                  .name,
                              quantity: tic.treatmentInformationDetail.value
                                  .treatmentInformations[index].quantity),
                          indicateToDrink: tic.treatmentInformationDetail.value
                              .treatmentInformations[index].indicationToDrink,
                        );
                      }),
                ],
              ),
              DisplayDetails(
                title: STATUSTREATMENT,
                info: tic.treatmentInformationDetail.value.isDelivered == true
                    ? "Đã xác nhận"
                    : "Chưa xác nhận",
                textStyle: TextStyle(
                    color:
                        tic.treatmentInformationDetail.value.isDelivered == true
                            ? success
                            : waring,
                    fontSize: 16),
              ),
              ImageSignature(
                title: SIGNATUREIMG,
                src:
                    tic.treatmentInformationDetail.value.confirmSignature ?? "",
                msg: tic.treatmentInformationDetail.value.isDelivered
                    ? "Không ký"
                    : "Chưa ký",
              ),
              DisplayDetails(
                title: CREATEDBY,
                info: tic.treatmentInformationDetail.value.createdBy ?? NOINFO,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
