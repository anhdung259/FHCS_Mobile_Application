// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treatment_info_result_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreatmentInfoResultSearch _$TreatmentInfoResultSearchFromJson(
    Map<String, dynamic> json) {
  return TreatmentInfoResultSearch(
    id: json['id'] as String,
    createAt: json['createAt'] as String,
    patientName: json['patientName'] as String,
    departmentName: json['departmentName'] as String,
    isDelivered: json['isDelivered'] as bool,
  );
}

Map<String, dynamic> _$TreatmentInfoResultSearchToJson(
        TreatmentInfoResultSearch instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createAt': instance.createAt,
      'patientName': instance.patientName,
      'departmentName': instance.departmentName,
      'isDelivered': instance.isDelivered,
    };
