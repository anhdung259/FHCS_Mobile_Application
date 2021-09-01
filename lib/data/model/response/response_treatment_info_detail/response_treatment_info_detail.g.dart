// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_treatment_info_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreatmentInfoDetailResponse _$TreatmentInfoDetailResponseFromJson(
    Map<String, dynamic> json) {
  return TreatmentInfoDetailResponse(
    id: json['id'] as String,
    patient: json['patient'] == null
        ? null
        : Patient.fromJson(json['patient'] as Map<String, dynamic>),
    departmentName: json['departmentName'] as String,
    confirmSignature: json['confirmSignature'] as String,
    createdBy: json['createdBy'] as String,
    createAt: json['createAt'] as String,
    month: json['month'] as int,
    diseaseStatuses: json['diseaseStatuses'] as String,
    allergies: (json['allergies'] as List)
        ?.map((e) =>
            e == null ? null : Allergy.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    treatmentInformations: (json['treatmentInformations'] as List)
        ?.map((e) => e == null
            ? null
            : ListResponseInTreatmentInfoDetail.fromJson(
                e as Map<String, dynamic>))
        ?.toList(),
    diagnostics: (json['diagnostics'] as List)
        ?.map((e) =>
            e == null ? null : Diagnostic.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    year: json['year'] as int,
    isDelivered: json['isDelivered'] as bool,
  );
}

Map<String, dynamic> _$TreatmentInfoDetailResponseToJson(
        TreatmentInfoDetailResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'patient': instance.patient,
      'departmentName': instance.departmentName,
      'confirmSignature': instance.confirmSignature,
      'createdBy': instance.createdBy,
      'createAt': instance.createAt,
      'isDelivered': instance.isDelivered,
      'month': instance.month,
      'year': instance.year,
      'allergies': instance.allergies,
      'treatmentInformations': instance.treatmentInformations,
      'diseaseStatusInTreatments': instance.diagnostics,
    };
