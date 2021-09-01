import 'package:fhcs_mobile_application/data/model/paging/info.dart';
import 'package:fhcs_mobile_application/data/model/treatment_info_result_search/treatment_info_result_search.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_treatment_info_result_list.g.dart';

@JsonSerializable()
class TreatmentInfoResultList {
  List<TreatmentInfoResultSearch> data;
  Info info;
  TreatmentInfoResultList(this.data, this.info);
  TreatmentInfoResultList.instance();
  TreatmentInfoResultList fromJson(Map<String, dynamic> json) {
    return _$TreatmentInfoResultListFromJson(json);
  }

  factory TreatmentInfoResultList.fromJson(Map<String, dynamic> json) =>
      _$TreatmentInfoResultListFromJson(json);
  Map<String, dynamic> toJson() => _$TreatmentInfoResultListToJson(this);
}
