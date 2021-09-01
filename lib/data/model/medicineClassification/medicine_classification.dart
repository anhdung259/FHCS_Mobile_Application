import 'package:json_annotation/json_annotation.dart';
part 'medicine_classification.g.dart';

@JsonSerializable()
class MedicineClassification {
  String id;
  String name;
  String description;
  @override
  String toString() => name;
  bool isEqual(MedicineClassification model) {
    return this?.id == model?.id;
  }

  MedicineClassification({this.id, this.description, this.name});
  MedicineClassification.instance();
  MedicineClassification fromJson(Map<String, dynamic> json) {
    return _$MedicineClassificationFromJson(json);
  }

  factory MedicineClassification.fromJson(Map<String, dynamic> json) =>
      _$MedicineClassificationFromJson(json);
  Map<String, dynamic> toJson() => _$MedicineClassificationToJson(this);
}
