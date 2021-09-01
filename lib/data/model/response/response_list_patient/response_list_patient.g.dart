// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_list_patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientList _$PatientListFromJson(Map<String, dynamic> json) {
  return PatientList(
    (json['data'] as List)
        ?.map((e) =>
            e == null ? null : Patient.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['info'] == null
        ? null
        : Info.fromJson(json['info'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PatientListToJson(PatientList instance) =>
    <String, dynamic>{
      'data': instance.data,
      'info': instance.info,
    };
