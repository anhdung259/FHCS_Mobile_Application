import 'package:fhcs_mobile_application/data/model/department/department.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_list_department.g.dart';

@JsonSerializable()
class DepartmentList {
  List<Department> data;
  DepartmentList(this.data);
  DepartmentList.instance();
  DepartmentList fromJson(Map<String, dynamic> json) {
    return _$DepartmentListFromJson(json);
  }

  factory DepartmentList.fromJson(Map<String, dynamic> json) =>
      _$DepartmentListFromJson(json);
  Map<String, dynamic> toJson() => _$DepartmentListToJson(this);
}
