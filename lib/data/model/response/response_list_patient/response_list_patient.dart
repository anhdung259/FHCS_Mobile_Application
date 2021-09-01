import 'package:fhcs_mobile_application/data/model/paging/info.dart';
import 'package:fhcs_mobile_application/data/model/patient/patient.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_list_patient.g.dart';

@JsonSerializable()
class PatientList {
  List<Patient> data;
  Info info;
  PatientList(this.data, this.info);
  PatientList.instance();
  PatientList fromJson(Map<String, dynamic> json) {
    return _$PatientListFromJson(json);
  }

  factory PatientList.fromJson(Map<String, dynamic> json) =>
      _$PatientListFromJson(json);
  Map<String, dynamic> toJson() => _$PatientListToJson(this);
}
