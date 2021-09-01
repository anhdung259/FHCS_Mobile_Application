import 'package:json_annotation/json_annotation.dart';
part 'medicine_subgroup.g.dart';

@JsonSerializable()
class MedicineSubgroup {
  String id;
  String name;
  @override
  String toString() => name;
  bool isEqual(MedicineSubgroup model) {
    return this?.id == model?.id;
  }

  MedicineSubgroup({this.id, this.name});
  MedicineSubgroup.instance();
  MedicineSubgroup fromJson(Map<String, dynamic> json) {
    return _$MedicineSubgroupFromJson(json);
  }

  factory MedicineSubgroup.fromJson(Map<String, dynamic> json) =>
      _$MedicineSubgroupFromJson(json);
  Map<String, dynamic> toJson() => _$MedicineSubgroupToJson(this);
}
