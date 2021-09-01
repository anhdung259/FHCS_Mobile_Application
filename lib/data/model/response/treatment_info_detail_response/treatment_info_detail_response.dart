import 'package:fhcs_mobile_application/data/model/diagnostic/diagnostic.dart';
import 'package:fhcs_mobile_application/data/model/medicine/medicine.dart';
import 'package:fhcs_mobile_application/data/model/treatment_information_details/treatment_information_details.dart';
import 'package:json_annotation/json_annotation.dart';
part 'treatment_info_detail_response.g.dart';

@JsonSerializable()
class ListResponseInTreatmentInfoDetail {
  String id;
  int quantity;
  String indicationToDrink;
  Medicine medicine;
  Diagnostic diagnostics;
  List<TreatmentInfoDetail> treatmentInformationDetails;
  ListResponseInTreatmentInfoDetail(
      {this.id,
      this.diagnostics,
      this.indicationToDrink,
      this.medicine,
      this.quantity,
      this.treatmentInformationDetails});
  ListResponseInTreatmentInfoDetail.instance();
  ListResponseInTreatmentInfoDetail fromJson(Map<String, dynamic> json) {
    return _$ListResponseInTreatmentInfoDetailFromJson(json);
  }

  factory ListResponseInTreatmentInfoDetail.fromJson(
          Map<String, dynamic> json) =>
      _$ListResponseInTreatmentInfoDetailFromJson(json);
  Map<String, dynamic> toJson() =>
      _$ListResponseInTreatmentInfoDetailToJson(this);
}
