import 'package:fhcs_mobile_application/data/model/medicineSubgroup/medicine_subgroup.dart';
import 'package:json_annotation/json_annotation.dart';
part 'response_list_subgroup.g.dart';

@JsonSerializable()
class MedicineSubgroupResponse {
  List<MedicineSubgroup> data;
  MedicineSubgroupResponse(this.data);
  MedicineSubgroupResponse.instance();
  MedicineSubgroupResponse fromJson(Map<String, dynamic> json) {
    return _$MedicineSubgroupResponseFromJson(json);
  }

  factory MedicineSubgroupResponse.fromJson(Map<String, dynamic> json) =>
      _$MedicineSubgroupResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MedicineSubgroupResponseToJson(this);
}

// MedicineSubgroupResponse _$MedicineSubgroupResponseFromJson(
//     Map<String, dynamic> json) {
//   return MedicineSubgroupResponse(
//     (json['data'] as List)
//         ?.map((e) => e == null
//             ? null
//             : MedicineSubgroup.fromJson(e as Map<String, dynamic>))
//         ?.toList(),
//   );
// }
