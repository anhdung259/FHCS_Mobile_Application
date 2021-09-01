import 'package:fhcs_mobile_application/data/model/contraindications/contraindications.dart';
import 'package:fhcs_mobile_application/data/model/diagnostic/diagnostic.dart';
import 'package:fhcs_mobile_application/data/model/medicineUnit/medicine_unit.dart';
import 'package:json_annotation/json_annotation.dart';
part 'medicine.g.dart';

@JsonSerializable()
class Medicine {
  String id;
  String name;
  String medicineUnitId;
  String description;
  String medicineSubgroupId;
  String medicineClassificationId;
  String createDate;
  String updateDate;
  String nameSubgroup;
  String nameClassification;
  String nameUnit;
  MedicineUnit medicineUnit;
  List<Diagnostic> diagnostics;
  List<Contraindications> contraindications;
  Medicine(
      {this.id,
      this.name,
      this.medicineUnitId,
      this.description,
      this.medicineSubgroupId,
      this.medicineClassificationId,
      this.createDate,
      this.updateDate,
      this.nameUnit,
      this.nameClassification,
      this.nameSubgroup,
      this.medicineUnit,
      this.diagnostics,
      this.contraindications});
  Medicine.instance();
  @override
  String toString() => name;
  Medicine fromJson(Map<String, dynamic> json) {
    return _$MedicineFromJson(json);
  }

  factory Medicine.fromJson(Map<String, dynamic> json) =>
      _$MedicineFromJson(json);
  Map<String, dynamic> toJson() => _$MedicineToJson(this);
}
