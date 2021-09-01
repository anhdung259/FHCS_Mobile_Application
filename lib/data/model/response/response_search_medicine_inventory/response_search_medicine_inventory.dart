import 'package:fhcs_mobile_application/data/model/medicine_inventory_result_search/medicine_inventory_result_search.dart';
import 'package:fhcs_mobile_application/data/model/paging/info.dart';
import 'package:json_annotation/json_annotation.dart';
part 'response_search_medicine_inventory.g.dart';

@JsonSerializable()
class MedicineInventoryResponseSearch {
  List<MedicineInventoryResultSearch> data;
  Info info;
  MedicineInventoryResponseSearch(this.data, this.info);
  MedicineInventoryResponseSearch.instance();
  MedicineInventoryResponseSearch fromJson(Map<String, dynamic> json) {
    return _$MedicineInventoryResponseSearchFromJson(json);
  }

  factory MedicineInventoryResponseSearch.fromJson(Map<String, dynamic> json) =>
      _$MedicineInventoryResponseSearchFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MedicineInventoryResponseSearchToJson(this);
}
