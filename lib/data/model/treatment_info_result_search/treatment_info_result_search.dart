import 'package:json_annotation/json_annotation.dart';
part 'treatment_info_result_search.g.dart';

@JsonSerializable()
class TreatmentInfoResultSearch {
  String id;
  String createAt;
  String patientName;
  String departmentName;
  bool isDelivered;

  TreatmentInfoResultSearch(
      {this.id,
      this.createAt,
      this.patientName,
      this.departmentName,
      this.isDelivered});
  TreatmentInfoResultSearch.instance();
  TreatmentInfoResultSearch fromJson(Map<String, dynamic> json) {
    return _$TreatmentInfoResultSearchFromJson(json);
  }

  factory TreatmentInfoResultSearch.fromJson(Map<String, dynamic> json) =>
      _$TreatmentInfoResultSearchFromJson(json);
  Map<String, dynamic> toJson() => _$TreatmentInfoResultSearchToJson(this);
}
