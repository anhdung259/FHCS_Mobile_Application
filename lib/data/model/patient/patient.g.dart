// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map<String, dynamic> json) {
  return Patient(
    id: json['id'] as String,
    name: json['name'] as String,
    internalCode: json['internalCode'] as String,
    gender: json['gender'] as String,
    departmentId: json['departmentId'] as String,
    allergies: (json['allergies'] as List)
        ?.map((e) =>
            e == null ? null : Allergy.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    department: json['department'] == null
        ? null
        : Department.fromJson(json['department'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'internalCode': instance.internalCode,
      'gender': instance.gender,
      'departmentId': instance.departmentId,
      'allergies': instance.allergies,
      'department': instance.department,
    };
