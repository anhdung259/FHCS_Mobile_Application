import 'package:fhcs_mobile_application/data/model/diagnostic/diagnostic.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_list_disease_status.g.dart';

@JsonSerializable()
class DiseaseStatusList {
  List<Diagnostic> data;
  DiseaseStatusList(this.data);
  DiseaseStatusList.instance();
  DiseaseStatusList fromJson(Map<String, dynamic> json) {
    return _$DiseaseStatusListFromJson(json);
  }

  factory DiseaseStatusList.fromJson(Map<String, dynamic> json) =>
      _$DiseaseStatusListFromJson(json);
  Map<String, dynamic> toJson() => _$DiseaseStatusListToJson(this);
}
