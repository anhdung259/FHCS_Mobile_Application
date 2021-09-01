import 'package:fhcs_mobile_application/data/model/allergy/allergy.dart';
import 'package:fhcs_mobile_application/data/model/department/department.dart';
import 'package:json_annotation/json_annotation.dart';
part 'patient.g.dart';

@JsonSerializable()
class Patient {
  String id;
  String name;
  String internalCode;
  String gender;
  String departmentId;
  List<Allergy> allergies;
  Department department;
  Patient(
      {this.id,
      this.name,
      this.internalCode,
      this.gender,
      this.departmentId,
      this.allergies,
      this.department});
  Patient.instance();
  @override
  String toString() => name;
  Patient fromJson(Map<String, dynamic> json) {
    return _$PatientFromJson(json);
  }

  factory Patient.fromJson(Map<String, dynamic> json) =>
      _$PatientFromJson(json);
  Map<String, dynamic> toJson() => _$PatientToJson(this);
}
