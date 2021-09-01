import 'package:fhcs_mobile_application/data/model/medicineClassification/medicine_classification.dart';
import 'package:fhcs_mobile_application/data/model/medicineSubgroup/medicine_subgroup.dart';
import 'package:fhcs_mobile_application/data/model/medicineUnit/medicine_unit.dart';
import 'package:json_annotation/json_annotation.dart';
part 'medicine_result_search.g.dart';

@JsonSerializable()
class MedicineResultSearch {
  String id;
  String name;
  String description;
  MedicineClassification medicineClassification;
  MedicineSubgroup medicineSubgroup;
  MedicineUnit medicineUnit;
  MedicineResultSearch({
    this.id,
    this.name,
    this.description,
    this.medicineClassification,
    this.medicineSubgroup,
    this.medicineUnit,
  });
  MedicineResultSearch.instance();
  MedicineResultSearch fromJson(Map<String, dynamic> json) {
    return _$MedicineResultSearchFromJson(json);
  }

  factory MedicineResultSearch.fromJson(Map<String, dynamic> json) =>
      _$MedicineResultSearchFromJson(json);
  Map<String, dynamic> toJson() => _$MedicineResultSearchToJson(this);
}
