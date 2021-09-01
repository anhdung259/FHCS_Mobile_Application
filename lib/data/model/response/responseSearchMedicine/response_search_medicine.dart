import 'package:fhcs_mobile_application/data/model/medicine_result_search/medicine_result_search.dart';
import 'package:fhcs_mobile_application/data/model/paging/info.dart';
import 'package:json_annotation/json_annotation.dart';
part 'response_search_medicine.g.dart';

@JsonSerializable()
class MedicineResponseSearch {
  List<MedicineResultSearch> data;
  Info info;
  MedicineResponseSearch(this.data, this.info);
  MedicineResponseSearch.instance();
  MedicineResponseSearch fromJson(Map<String, dynamic> json) {
    return _$MedicineResponseSearchFromJson(json);
  }

  factory MedicineResponseSearch.fromJson(Map<String, dynamic> json) =>
      _$MedicineResponseSearchFromJson(json);
  Map<String, dynamic> toJson() => _$MedicineResponseSearchToJson(this);
}
