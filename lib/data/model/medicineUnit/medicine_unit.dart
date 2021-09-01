import 'package:json_annotation/json_annotation.dart';
part 'medicine_unit.g.dart';

@JsonSerializable()
class MedicineUnit {
  String id;
  String name;
  String acronymUnit;
  @override
  String toString() => name;
  bool isEqual(MedicineUnit model) {
    return this?.id == model?.id;
  }

  MedicineUnit({this.id, this.acronymUnit, this.name});
  MedicineUnit.instance();
  MedicineUnit fromJson(Map<String, dynamic> json) {
    return _$MedicineUnitFromJson(json);
  }

  factory MedicineUnit.fromJson(Map<String, dynamic> json) =>
      _$MedicineUnitFromJson(json);
  Map<String, dynamic> toJson() => _$MedicineUnitToJson(this);
}
