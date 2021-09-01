import 'package:json_annotation/json_annotation.dart';
part 'department.g.dart';

@JsonSerializable()
class Department {
  String id;
  String name;
  String description;
  @override
  String toString() => name;
  bool isEqual(Department model) {
    return this?.id == model?.id;
  }

  Department({this.id, this.name, this.description});
  Department.instance();
  Department fromJson(Map<String, dynamic> json) {
    return _$DepartmentFromJson(json);
  }

  factory Department.fromJson(Map<String, dynamic> json) =>
      _$DepartmentFromJson(json);
  Map<String, dynamic> toJson() => _$DepartmentToJson(this);
}
