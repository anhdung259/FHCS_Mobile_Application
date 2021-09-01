import 'dart:io';

import 'package:fhcs_mobile_application/data/model/treatmentInfo/treatment_info.dart';
import 'package:fhcs_mobile_application/data/model/treatment_information_details/treatment_information_details.dart';

class InsertTreatmentInfoRequest {
  String name;
  String internalCode;
  String gender;
  String departmentId;
  String diseaseStatuses;
  List<String> allergyIds;
  List<String> diagnosticIds;
  List<TreatmentInfoDetail> treatmentInformationDetails;
  List<TreatmentInfo> treatmentInformations;
  File confirmSignatureImg;
  bool isDelivered;

  InsertTreatmentInfoRequest(
      {this.name,
      this.internalCode,
      this.gender,
      this.diseaseStatuses,
      this.departmentId,
      this.allergyIds,
      this.diagnosticIds,
      this.treatmentInformationDetails,
      this.treatmentInformations,
      this.confirmSignatureImg,
      this.isDelivered});
}
