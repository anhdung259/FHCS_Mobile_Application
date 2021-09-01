// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_treatment_info_result_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreatmentInfoResultList _$TreatmentInfoResultListFromJson(
    Map<String, dynamic> json) {
  return TreatmentInfoResultList(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : TreatmentInfoResultSearch.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['info'] == null
        ? null
        : Info.fromJson(json['info'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TreatmentInfoResultListToJson(
        TreatmentInfoResultList instance) =>
    <String, dynamic>{
      'data': instance.data,
      'info': instance.info,
    };
