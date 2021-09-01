import 'package:fhcs_mobile_application/data/model/allergy/allergy.dart';
import 'package:fhcs_mobile_application/data/model/diagnostic/diagnostic.dart';
import 'package:fhcs_mobile_application/data/model/patient/patient.dart';
import 'package:fhcs_mobile_application/data/model/response/treatment_info_detail_response/treatment_info_detail_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'response_treatment_info_detail.g.dart';

@JsonSerializable()
class TreatmentInfoDetailResponse {
  String id;
  Patient patient;
  String departmentName;
  String confirmSignature;
  String createdBy;
  String createAt;
  bool isDelivered;
  String diseaseStatuses;
  int month;
  int year;
  List<Allergy> allergies;
  List<ListResponseInTreatmentInfoDetail> treatmentInformations;
  List<Diagnostic> diagnostics;

  TreatmentInfoDetailResponse(
      {this.id,
      this.patient,
      this.departmentName,
      this.confirmSignature,
      this.createdBy,
      this.createAt,
      this.month,
      this.allergies,
      this.treatmentInformations,
      this.diagnostics,
      this.year,
      this.diseaseStatuses,
      this.isDelivered});
  TreatmentInfoDetailResponse.instance();
  TreatmentInfoDetailResponse fromJson(Map<String, dynamic> json) {
    return _$TreatmentInfoDetailResponseFromJson(json);
  }

  factory TreatmentInfoDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$TreatmentInfoDetailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TreatmentInfoDetailResponseToJson(this);
}
