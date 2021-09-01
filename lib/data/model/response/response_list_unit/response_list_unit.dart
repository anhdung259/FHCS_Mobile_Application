import 'package:fhcs_mobile_application/data/model/medicineUnit/medicine_unit.dart';
import 'package:json_annotation/json_annotation.dart';
part 'response_list_unit.g.dart';

@JsonSerializable()
class MedicineUnitResponse {
  List<MedicineUnit> data;
  MedicineUnitResponse(this.data);
  MedicineUnitResponse.instance();
  MedicineUnitResponse fromJson(Map<String, dynamic> json) {
    return _$MedicineUnitResponseFromJson(json);
  }

  factory MedicineUnitResponse.fromJson(Map<String, dynamic> json) =>
      _$MedicineUnitResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MedicineUnitResponseToJson(this);
}
