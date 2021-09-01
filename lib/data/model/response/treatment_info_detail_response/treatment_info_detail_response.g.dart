// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treatment_info_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListResponseInTreatmentInfoDetail _$ListResponseInTreatmentInfoDetailFromJson(
    Map<String, dynamic> json) {
  return ListResponseInTreatmentInfoDetail(
    id: json['id'] as String,
    diagnostics: json['diseaseStatus'] == null
        ? null
        : Diagnostic.fromJson(json['diseaseStatus'] as Map<String, dynamic>),
    indicationToDrink: json['indicationToDrink'] as String,
    medicine: json['medicine'] == null
        ? null
        : Medicine.fromJson(json['medicine'] as Map<String, dynamic>),
    quantity: json['quantity'] as int,
    treatmentInformationDetails: (json['treatmentInformationDetails'] as List)
        ?.map((e) => e == null
            ? null
            : TreatmentInfoDetail.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ListResponseInTreatmentInfoDetailToJson(
        ListResponseInTreatmentInfoDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quantity': instance.quantity,
      'indicationToDrink': instance.indicationToDrink,
      'medicine': instance.medicine,
      'diseaseStatus': instance.diagnostics,
      'treatmentInformationDetails': instance.treatmentInformationDetails,
    };
